namespace :games_tasks do
  desc "TODO"
  task games_json: :environment do
    x = 0
    @games = JSON.parse File.read(Rails.root.join('app', 'assets', 'jsons', 'Game.2018.json'))
    @games.each do |game|
      @season = Season.find_by(end_year: game["Season"])
      @hometeam = Team.find_by(key: game["HomeTeam"])
      @awayteam = Team.find_by(key: game["AwayTeam"])
      @hometeamseason = TeamSeason.find_by(team: @hometeam, season: @season)
      @awayteamseason = TeamSeason.find_by(team: @awayteam, season: @season)
      currentgame = Game.find_or_initialize_by(global_game_id: game["GameID"])
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