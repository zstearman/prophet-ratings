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

end
