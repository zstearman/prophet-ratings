namespace :games_tasks do
  desc "TODO"
  task games_json: :environment do
    x = 0
    @games = JSON.parse File.read(Rails.root.join('app', 'assets', 'jsons', 'Game.2018.json'))
    @games.each do |game|
      @season = Season.find_by(end_year: game["Season"])
      @hometeam = Team.find_by(key: game["HomeTeam"])
      @awayteam = Team.find_by(key: game["AwayTeam"])
      currentgame = Game.find_or_initialize_by(global_game_id: game["GlobalGameID"])
      if currentgame
        currentgame.home_team = game["HomeTeam"]
        currentgame.away_team = game["AwayTeam"]
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
