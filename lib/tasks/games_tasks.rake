require 'task_helpers/application_helper'

namespace :games_tasks do
  desc "Get games from FantasyData.com"
  task get_games: :environment do
    x = 0
    y = 0
    @season = Season.find_by(current: true)
    start_date = @season.regular_season_start_date
    if Date.today < start_date + 200.days
      end_date = Date.today
    else
      end_date = start_date + 200.days
    end
    current_date = start_date
    while current_date <= end_date do
      uri = URI('https://api.fantasydata.net/v3/cbb/stats/JSON/GamesByDate/' + current_date.to_s)
      request = Net::HTTP::Get.new(uri.request_uri)
      # Request headers
      # Currently using trial subscription key
      request['Ocp-Apim-Subscription-Key'] = 'ce3dce505f5540688889d2f547550d28'
      # Request body
      request.body = ""
      
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
      end
      @games =  JSON.parse response.body
      @games.each do |game|
        @hometeam = Team.find_by(global_team_id: game["GlobalHomeTeamID"])
        @awayteam = Team.find_by(global_team_id: game["GlobalAwayTeamID"])
        @hometeamseason = TeamSeason.find_by(team: @hometeam, season: @season)
        @awayteamseason = TeamSeason.find_by(team: @awayteam, season: @season)
        currentgame = Game.find_or_initialize_by(global_game_id: game["GlobalGameID"])
        if currentgame
          currentgame.season_id = @season.id
          currentgame.home_team = @hometeam
          currentgame.away_team = @awayteam
          currentgame.home_team_season = @hometeamseason
          currentgame.away_team_season = @awayteamseason
          currentgame.status = game["Status"]
          currentgame.home_team_key = game["HomeTeam"]
          currentgame.away_team_key = game["AwayTeam"]
          currentgame.away_score = game["AwayTeamScore"]
          currentgame.home_score = game["HomeTeamScore"]
          currentgame.season_type = game["SeasonType"]
          currentgame.updated = game["Updated"]
          currentgame.period = game["Period"]
          currentgame.point_spread = game["PointSpread"]
          currentgame.over_under = game["OverUnder"]
          currentgame.away_money_line = game["AwayMoneyLine"]
          currentgame.home_money_line = game["HomeMoneyLine"]
          currentgame.tournament_id  = game["TournamentID"]
          currentgame.bracket = game["Bracket"]
          currentgame.round = game["Round"]
          currentgame.away_seed = game["AwaySeed"]
          currentgame.home_seed = game["HomeSeed"]
          currentgame.away_previous_global_game_id = game["AwayPreviousGlobalGameID"]
          currentgame.home_previous_global_game_id = game["HomePreviousGlobalGameID"]
          currentgame.tournament_display_order = game["TournamentDisplayOrder"]
          currentgame.date = ApplicationHelper.convert_date(game["DateTime"])
          currentgame.date_time = ApplicationHelper.convert_date_time(game["DateTime"])
          if currentgame.save
             x = x + 1
          else
            puts game["DateTime"].to_s + " " + game["AwayTeam"] + "@" + game["HomeTeam"]
            currentgame.errors.full_messages.each do |msg|
              puts msg
            end
          end
        else
          puts game
        end
      end
      current_date += 1.day
      y += 1
      if y % 10 == 0
        puts y.to_s + " days added so far."
      end
    end
    puts x.to_s + " games added or updated."
  end
  
  desc "TODO"
  task games_json: :environment do
    x = 0
    @games = JSON.parse File.read(Rails.root.join('app', 'assets', 'jsons', 'Game.2018.json'))
    @games.each do |game|
      @season = Season.find_by(season: game["Season"])
      @hometeam = Team.find_by(global_team_id: game["GlobalHomeTeamID"])
      @awayteam = Team.find_by(global_team_id: game["GlobalAwayTeamID"])
      @hometeamseason = TeamSeason.find_by(team: @hometeam, season: @season)
      @awayteamseason = TeamSeason.find_by(team: @awayteam, season: @season)
      currentgame = Game.find_or_initialize_by(global_game_id: game["GlobalGameID"])
      if currentgame
        currentgame.home_team = @hometeam
        currentgame.away_team = @awayteam
        currentgame.home_team_season = @hometeamseason
        currentgame.away_team_season = @awayteamseason
        currentgame.status = game["Status"]
        currentgame.home_team_key = game["HomeTeam"]
        currentgame.away_team_key = game["AwayTeam"]
        currentgame.away_score = game["AwayTeamScore"]
        currentgame.home_score = game["HomeTeamScore"]
        currentgame.season_type = game["SeasonType"]
        currentgame.updated = game["Updated"]
        currentgame.period = game["Period"]
        currentgame.point_spread = game["PointSpread"]
        currentgame.over_under = game["OverUnder"]
        currentgame.away_money_line = game["AwayMoneyLine"]
        currentgame.home_money_line = game["HomeMoneyLine"]
        currentgame.tournament_id  = game["TournamentID"]
        currentgame.bracket = game["Bracket"]
        currentgame.round = game["Round"]
        currentgame.away_seed = game["AwaySeed"]
        currentgame.home_seed = game["HomeSeed"]
        currentgame.away_previous_global_game_id = game["AwayPreviousGlobalGameID"]
        currentgame.home_previous_global_game_id = game["HomePreviousGlobalGameID"]
        currentgame.tournament_display_order = game["TournamentDisplayOrder"]
        gameday = game["Day"]
        if gameday
          currentgame.date = Date.strptime(gameday, '%m/%d/%Y')
          currentgame.date_time = DateTime.strptime(game["DateTime"], '%m/%d/%Y %I:%M:%S %p')
        else
          currentgame.date = DateTime.strptime('01/01/2099 12:00:00 AM', '%m/%d/%Y %I:%M:%S %p')
        end
        if currentgame.save
           x = x + 1
        else
          currentgame.errors.full_messages.each do |msg|
            puts currentgame
            puts msg
          end
        end
      else
        puts game
      end
    end
    puts x.to_s + " games added or updated."
  end

end