
namespace :teams_tasks do
  desc "TODO"
  task import_teams: :environment do
    @doc = Nokogiri::XML(open(Rails.root.join('app', 'assets', 'xmls', 'Team.2018.xml')))
    teams = @doc.xpath("//Team")
    teams.each do |team|
      school = team.xpath('School').text
      puts school
    end
  end

end
