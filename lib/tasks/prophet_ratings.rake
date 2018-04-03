namespace :prophet_ratings do
  desc "Generate Prophet Ratings after all tables are added."
  task generate_ratings: :environment do
    attempts = 0
    error = 10000
    avg_ort = 100
    avg_drt = 100
    avg_tempo = 70
    TeamSeason.all.each do |team_season|
      team_prtg = ProphetRating.find_or_initialize_by(team_season: team_season)
      team_prtg.p_ortg ||= avg_ort
      team_prtg.p_drtg ||= avg_drt
      team_prtg.p_tempo ||= avg_tempo
      team_prtg.save
    end
    loop do
      puts attempts.to_s + " iterations. Error of " + error.to_s + "."
      break if attempts >= 5 or error <= 100
      attempts += 1
      TeamSeason.all.each do |team_season|
        team_prtg = team_season.prophet_rating
        team_ortg = []
        team_drtg = []
        team_tempo = []
        team_season.team_game.all.each do |team_game|
          game = team_game.game
          if team_game.opponent_key == game.home_team_key
            if game.home_team_season && game.status == "Final"
              opponent_prtg = game.home_team_season.prophet_rating
              expected_tempo = avg_tempo + ((team_prtg.p_tempo - avg_tempo) + (opponent_prtg.p_tempo - avg_tempo))
              actual_tempo = team_game.possessions
              expected_ortg = avg_ort + ((team_prtg.p_ortg - avg_ort) + (opponent_prtg.p_drtg - avg_drt))
              actual_ortg = (100 * game.away_score) / actual_tempo
              team_ortg.push(actual_ortg)
              expected_drtg = avg_drt + ((team_prtg.p_drtg - avg_drt) + (opponent_prtg.p_ortg - avg_ort))
              actual_drtg = (100 * game.home_score) / actual_tempo
              adj_ortg = team_prtg.p_ortg + actual_ortg - expected_ortg
              adj_drtg = team_prtg.p_drtg + actual_drtg - expected_drtg
              adj_tempo = team_prtg.p_tempo + actual_tempo - expected_tempo
              team_ortg.push(adj_ortg)
              team_drtg.push(adj_drtg)
              team_tempo.push(adj_tempo)
            end
          elsif team_game.opponent_key == game.away_team_key
            # handle home games
          else
            # handle errors
          end
          
        end
        if team_ortg.size > 0 && team_drtg.size > 0
        team_prtg.p_ortg = team_ortg.inject{ |sum, el| sum + el}.to_f / team_ortg.size
        team_prtg.p_drtg = team_drtg.inject{ |sum, el| sum + el}.to_f / team_drtg.size
        team_prtg.p_tempo = team_tempo.inject{ |sum, el| sum + el}.to_f / team_tempo.size
        team_prtg.save
        else
          puts "Check problem with" + team_season.team.school
        end
      end
    end
  end

end
