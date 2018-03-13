require 'nokogiri'

namespace :teams_tasks do
  desc "TODO"
  task import_teams: :environment do
    @doc = Nokogiri::XML(open(Rails.root.join('app', 'assets', 'xmls', 'TeamSeason.2018.xml'))) do |config|
      config.nononet
    end
    puts @doc
    teams = @doc.xpath("//Team")
    teams.each do |team|
      school = team.xpath('School').text
      puts school
    end
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
      currentteam.ap_rank = team["ApRank"]
      currentteam.team_logo_url = team["TeamLogoUrl"]
      currentteam.save
      x = x + 1
    end
    puts x.to_s + " teams added or updated."
  end

end
