require 'net/http'
    
namespace :conferences_tasks do
  desc "TODO"
  task get_conferences: :environment do


    uri = URI('https://api.fantasydata.net/v3/cbb/scores/JSON/LeagueHierarchy')
    
    request = Net::HTTP::Get.new(uri.request_uri)
    # Request headers
    # Currently using trial subscription key
    request['Ocp-Apim-Subscription-Key'] = 'ce3dce505f5540688889d2f547550d28'
    # Request body
    request.body = ""
    
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end
    x = 0
    y = 0
    @hierarchy =  JSON.parse response.body
    @hierarchy.each do |conference|
      @conference = Conference.find_or_initialize_by(global_conference_id: conference["ConferenceID"])
       @conference.name = conference["Name"]
      if @conference.save
        y += 1
      end
      conference["Teams"].each do |team|
        if team["Key"] == "MKC"
          @team = Team.find_by(key: "UMKC") 
        else
          @team = Team.find_by(key: team["Key"])
        end
        if @team
          @team.conference = @conference
          @team.active = true
          if @team.save
            x += 1
          end
        end
      end

    end
    puts x.to_s + " teams sorted into " + y.to_s + " conferences."
  end

  task print_conferences: :environment do
    Conference.all.each do |conference|
      puts conference.id.to_s + ", " + conference.name
    end
  end
  
  task get_conference_keys: :environment do
    @conferences = JSON.parse File.read(Rails.root.join('app', 'assets', 'jsons', 'ConferenceKeys.json'))
    @conferences.each do |conference|
      @conference = Conference.find_by(name: conference["Name"])
      @conference.key = conference["Key"]
      @conference.save
    end
  end
end
