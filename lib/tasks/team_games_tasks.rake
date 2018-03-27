namespace :team_games_tasks do
  desc "TODO"
  task team_games_json: :environment do
    x = 0
    @team_games = JSON.parse File.read(Rails.root.join('app', 'assets', 'jsons', 'TeamGame.2018.json'))
    @team_games.each do |team_game|
      @season = Season.find_by(end_year: team_game["Season"])
      @team = Team.find_by(key: team_game["Team"])
      @opponent = Team.find_by(key: team_game["Opponent"])
      @teamseason = TeamSeason.find_by(team: @team, season: @season)
      currentgame = TeamGame.find_or_initialize_by(global_game_id: team_game["StatID"])
      if currentgame
        currentgame.team = @team
        currentgame.opponent_id = @opponent.id
        currentgame.team_season = @teamseason
        # currentgame.status = game["Status"]
        currentgame.wins = team_game["Wins"]
        currentgame.losses = team_game["Losses"]
        currentgame.conference_wins = team_game["ConferenceWins"]
        currentgame.conference_losses = team_game["ConferenceLosses"]
        currentgame.possessions = team_game["Possessions"]
        currentgame.opponent_key = team_game["Opponent"]
        if team_game["HomeOrAway"] == "HOME"
          currentgame.home = true
        else
          currentgame.home = false
        end
        currentgame.updated = team_game["Updated"]
        currentgame.season_type = team_game["SeasonType"]
        currentgame.field_goals_made = team_game["FieldGoalsMade"]
        currentgame.field_goals_attempted = team_game["FieldGoalsAttempted"]
        currentgame.field_goals_percentage = team_game["FieldGoalsPercentage"]
        currentgame.effective_field_goal_percentage = team_game["EffectiveFieldGoalsPercentage"]
        currentgame.two_pointers_made = team_game["TwoPointersMade"]
        currentgame.two_pointers_attempted = team_game["TwoPointersAttempted"]
        currentgame.two_pointers_percentage = team_game["TwoPointersPercentage"]
        currentgame.three_pointers_made = team_game["ThreePointersMade"]
        currentgame.three_pointers_attempted = team_game["ThreePointersAttempted"]
        currentgame.three_pointers_percentage = team_game["ThreePointersPercentage"]
        currentgame.free_throws_made = team_game["FreeThrowsMade"]
        currentgame.free_throws_attempted = team_game["FreeThrowsAttempted"]
        currentgame.free_throws_percentage = team_game["FreeThrowsPercentage"]
        currentgame.offensive_rebounds = team_game["OffensiveRebounds"]
        currentgame.defensive_rebounds = team_game["DefensiveRebounds"]
        currentgame.rebounds = team_game["Rebounds"]
        currentgame.assists = team_game["Assists"]
        currentgame.steals = team_game["Steals"]
        currentgame.blocked_shots = team_game["BlockedShots"]
        currentgame.turnovers = team_game["Turnovers"]
        currentgame.personal_fouls = team_game["PersonalFouls"]
        currentgame.points = team_game["Points"]
        currentgame.true_shooting_percentage = team_game["TrueShootingPercentage"]
        currentgame.true_shooting_attempts = team_game["TrueShootingAttempts"]
        if team_game["Day"]
          currentgame.day = Date.strptime(team_game["Day"], '%m/%d/%Y')
          currentgame.date_time = DateTime.strptime(team_game["DateTime"], '%m/%d/%Y %I:%M:%S %p')
        else
          currentgame.day = DateTime.strptime('01/01/2099 12:00:00 AM', '%m/%d/%Y %I:%M:%S %p')
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
