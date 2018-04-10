require 'net/http'
    
namespace :conferences_tasks do
  desc "TODO"
  task get_conferences: :environment do


    uri = URI('https://api.fantasydata.net/v3/cbb/scores/JSON/LeagueHierarchy')
    
    request = Net::HTTP::Get.new(uri.request_uri)
    # Request headers
    # Currently using trial subscription key
    request['Ocp-Apim-Subscription-Key'] = '8b5aef100e21492e869155a34e58e245'
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
      conference["Teams"].each do |team|
        @team = Team.find_by(key: team["Key"])
        if @team
          @team.conference = @conference
          @team.active = true
          if @team.save
            x += 1
          end
        end
      end
      @conference.name = conference["Name"]
      if @conference.save
        y += 1
      end
    end
    puts x.to_s + " teams sorted into " + y.to_s + " conferences."
  end

end
