require 'task_helpers/application_helper'
  
namespace :seasons_tasks do

  
  desc "Get Season Info From Fantasy Data"
  task get_seasons: :environment do
    Season.all.each do |season|
      season.current = false
      season.save
    end
    uri = URI('https://api.fantasydata.net/v3/cbb/stats/JSON/CurrentSeason')
    
    request = Net::HTTP::Get.new(uri.request_uri)
    # Request headers
    # Currently using trial subscription key
    request['Ocp-Apim-Subscription-Key'] = '8b5aef100e21492e869155a34e58e245'
    # Request body
    request.body = ""
    
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end
    @current_season =  JSON.parse response.body
    @season = Season.find_or_initialize_by(season: @current_season["Season"])
    @season.start_year = @current_season["StartYear"]
    @season.end_year = @current_season["EndYear"]
    @season.description = @current_season["Description"]
    @season.regular_season_start_date = ApplicationHelper.convert_date(@current_season["RegularSeasonStartDate"])
    @season.post_season_start_date = ApplicationHelper.convert_date(@current_season["PostSeasonStartDate"])
    @season.current = true
    if @season.save
      puts "Season successfully saved."
    end
  end

end
