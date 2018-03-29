namespace :team_seasons_tasks do
  desc "TODO"
  task team_seasons_json: :environment do
    x = 0
    @team_seasons = JSON.parse File.read(Rails.root.join('app', 'assets', 'jsons', 'TeamSeason.2018.json'))
    @team_seasons.each do |team_season|
      @season = Season.find_by(end_year: team_season["Season"])
      @team = Team.find_by(key: team_season["Team"])
      currentseason = TeamSeason.find_or_initialize_by(team_id: @team.id, season_id: @season.id)
      if currentseason
        currentseason.school = @team.school
        currentseason.wins = team_season["Wins"]
        currentseason.losses = team_season["Losses"]
        currentseason.conference_wins = team_season["ConferenceWins"]
        currentseason.conference_losses = team_season["ConferenceLosses"]
        currentseason.possessions = team_season["Possessions"]
        currentseason.updated = team_season["Updated"]
        currentseason.games = team_season["Games"]
        currentseason.minutes = team_season["Minutes"]
        currentseason.field_goals_made = team_season["FieldGoalsMade"]
        currentseason.field_goals_attempted = team_season["FieldGoalsAttempted"]
        currentseason.field_goals_percentage = team_season["FieldGoalsPercentage"]
        currentseason.effective_field_goal_percentage = team_season["EffectiveFieldGoalsPercentage"]
        currentseason.two_pointers_made = team_season["TwoPointersMade"]
        currentseason.two_pointers_attempted = team_season["TwoPointersAttempted"]
        currentseason.two_pointers_percentage = team_season["TwoPointersPercentage"]
        currentseason.three_pointers_made = team_season["ThreePointersMade"]
        currentseason.three_pointers_attempted = team_season["ThreePointersAttempted"]
        currentseason.three_pointers_percentage = team_season["ThreePointersPercentage"]
        currentseason.free_throws_made = team_season["FreeThrowsMade"]
        currentseason.free_throws_attempted = team_season["FreeThrowsAttempted"]
        currentseason.free_throws_percentage = team_season["FreeThrowsPercentage"]
        currentseason.offensive_rebounds = team_season["OffensiveRebounds"]
        currentseason.defensive_rebounds = team_season["DefensiveRebounds"]
        currentseason.rebounds = team_season["Rebounds"]
        currentseason.assists = team_season["Assists"]
        currentseason.steals = team_season["Steals"]
        currentseason.blocked_shots = team_season["BlockedShots"]
        currentseason.turnovers = team_season["Turnovers"]
        currentseason.personal_fouls = team_season["PersonalFouls"]
        currentseason.points = team_season["Points"]
        currentseason.true_shooting_attempts = team_season["TrueShootingAttempts"]
        currentseason.true_shooting_percentage = team_season["TrueShootingPercentage"]
        currentseason.fantasy_points_fan_duel = team_season["FantasyPointsFanDuel"]
        currentseason.season_type = team_season["SeasonType"]
        currentseason.global_team_season_id = team_season["StatID"]
        currentseason.ap_rank = @team.ap_rank
        currentseason.p_tempo = currentseason.possessions / ( currentseason.games * 1.0 )
        currentseason.assists_percentage = currentseason.assists / ( currentseason.field_goals_made * 1.0 )
        currentseason.turnovers_percentage = currentseason.turnovers / ( currentseason.possessions * 1.0 )
        if currentseason.save
           x = x + 1
        else
          currentseason.errors.full_messages.each do |msg|
            puts currentseason
            puts currentseason.team
            puts msg
          end
        end
      else
        puts team_season
      end
    end
    puts x.to_s + " team seasons added or updated."
  end

  task team_seasons_calculations: :environment do
    x = 0
    y = 0 
    z = 0
    @team_seasons = TeamSeason.all.each do |team_season|
      offensive_rebounds = 0
      defensive_rebounds = 0
      offensive_rebounds_allowed = 0
      defensive_rebounds_allowed = 0
      opponent_possessions = 0
      blocks = 0
      steals = 0
      team_games = team_season.team_game.all
      team_games.each do |game|
        y += 1
        opponent_game = TeamGame.find(game.opponent_game_id)
        offensive_rebounds += game.offensive_rebounds
        defensive_rebounds += game.defensive_rebounds
        offensive_rebounds_allowed += opponent_game.offensive_rebounds
        defensive_rebounds_allowed += opponent_game.defensive_rebounds
        if opponent_game.possessions
          opponent_possessions += opponent_game.possessions
          blocks += game.blocked_shots
          steals += game.steals
          z += 1
        end
      end
      team_season.offensive_rebounds_percentage = (offensive_rebounds.to_f / (offensive_rebounds + defensive_rebounds_allowed))
      team_season.defensive_rebounds_percentage = (defensive_rebounds.to_f / (defensive_rebounds + offensive_rebounds_allowed))
      team_season.total_rebounds_percentage = ((offensive_rebounds.to_f + defensive_rebounds) / (offensive_rebounds + offensive_rebounds_allowed + defensive_rebounds + defensive_rebounds_allowed))
      team_season.free_throws_per_field_goal_attempted = team_season.free_throws_attempted.to_f / team_season.field_goals_attempted
      team_season.three_pointers_per_field_goal_attempted = team_season.three_pointers_attempted.to_f / team_season.field_goals_attempted
      team_season.blocks_percentage = blocks.to_f / opponent_possessions
      team_season.steals_percentage = steals.to_f / opponent_possessions
      team_season.save
      x += 1
    end
    puts x.to_s + " seasons calculations performed. " + (z.to_f/y).to_s + " percent of games had possessions."
  end
end
