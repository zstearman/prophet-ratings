require 'nokogiri'

namespace :teams_tasks do
  
  desc "Get teams from FantasyData"
  task get_teams: :environment do
    uri = URI('https://api.fantasydata.net/v3/cbb/stats/JSON/teams')
  
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
    @teams =  JSON.parse response.body
    @teams.each do |team|
      currentteam = Team.find_or_initialize_by(school: team["School"])
      currentteam.key = team["Key"]
      currentteam.active = false
      currentteam.name = team["Name"]
      currentteam.team_logo_url = team["TeamLogoUrl"]
      currentteam.ap_rank = team["ApRank"]
      currentteam.global_team_id = team["GlobalTeamID"]
      currentteam.save
      x = x + 1
    end
    puts x.to_s + " teams added or updated."
  end
    
  desc "TODO"
  task teams_json: :environment do
    x = 0
    @teams = JSON.parse File.read(Rails.root.join('app', 'assets', 'jsons', 'Team.2018.json'))
    @teams.each do |team|
      currentteam = Team.find_or_initialize_by(school: team["School"])
      currentteam.key = team["[Key]"]
      currentteam.active = team["Active"]
      currentteam.name = team["Name"]
      currentteam.team_logo_url = team["TeamLogoUrl"]
      currentteam.ap_rank = team["ApRank"]
      currentteam.global_team_id = team["GlobalTeamID"]
      currentteam.save
      x = x + 1
    end
    puts x.to_s + " teams added or updated."
  end

end
