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
      currentgame = Game.find_or_initialize_by(global_game_id: game["GlobalGameID"])
      if currentgame
        currentgame.home_team = game["HomeTeam"]
        currentgame.away_team = game["AwayTeam"]
        currentgame.home_team_season = @hometeamseason
        currentgame.away_team_season = @awayteamseason
        currentgame.away_score = game["AwayTeamScore"]
        currentgame.home_score = game["HomeTeamScore"]
        gameday = game["Day"]
        if gameday
          currentgame.date = Date.strptime(gameday, '%m/%d/%Y')
        else
          currentgame.date = Date.strptime('01/01/2099', '%m/%d/%Y')
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
