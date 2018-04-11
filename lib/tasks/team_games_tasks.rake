require 'task_helpers/application_helper'

namespace :team_games_tasks do
  
  desc "Get team games from FantasyData.com"
  task get_team_games: :environment do
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
      uri = URI('https://api.fantasydata.net/v3/cbb/stats/JSON/TeamGameStatsByDate/' + current_date.to_s)
      request = Net::HTTP::Get.new(uri.request_uri)
      # Request headers
      # Currently using trial subscription key
      request['Ocp-Apim-Subscription-Key'] = 'ce3dce505f5540688889d2f547550d28'
      # Request body
      request.body = ""
      
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
      end
      @team_games =  JSON.parse response.body
      @team_games.each do |team_game|
        @team = Team.find_by(global_team_id: team_game["GlobalTeamID"])
        @opponent = Team.find_by(global_team_id: team_game["GlobalOpponentID"])
        @teamseason = TeamSeason.find_by(team: @team, season: @season)
        @game = Game.find_by(global_game_id: team_game["GlobalGameID"])
        currentgame = TeamGame.find_or_initialize_by(global_game_id: team_game["StatID"])
        if currentgame && @teamseason
          currentgame.team = @team
          if @opponent
            currentgame.opponent_id = @opponent.id
          end
          currentgame.team_season = @teamseason
          if @game
            currentgame.game = @game
          end
          # currentgame.status = game["Status"]
          currentgame.wins = team_game["Wins"]
          currentgame.losses = team_game["Losses"]
          currentgame.conference_wins = team_game["ConferenceWins"]
          currentgame.conference_losses = team_game["ConferenceLosses"]
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
          currentgame.possessions = currentgame.field_goals_attempted - currentgame.offensive_rebounds + currentgame.turnovers + ( 0.42 * currentgame.free_throws_attempted)
          currentgame.date = ApplicationHelper.convert_date(team_game["DateTime"])
          currentgame.date_time = ApplicationHelper.convert_date_time(team_game["DateTime"])
          if currentgame.save
             x = x + 1
          else
            currentgame.errors.full_messages.each do |msg|
              puts currentgame
              puts msg
            end
          end
        end
      end
      y += 1
      current_date += 1.day
      if y % 10 == 0
        puts x.to_s + " team games added over " + y.to_s + " days so far."
      end
    end
    z = 0
    TeamGame.all.each do |team_game|
      if team_game.game && team_game.team && team_game.opponent_id
        @game = team_game.game
        @opponent_game = @game.team_games.find_by(opponent_key: team_game.team_key)
        if @opponent_game
          team_game.opponent_game_id = @opponent_game.id
        else
          puts team_game
          z += 1
        end
        team_game.save
      end
    end
    puts z.to_s + " opponent games with errors."
    puts x.to_s + " games added or updated."
  end
  
  desc "TODO"
  task team_games_json: :environment do
    x = 0
    @team_games = JSON.parse File.read(Rails.root.join('app', 'assets', 'jsons', 'TeamGame.2018.json'))
    @team_games.each do |team_game|
      @season = Season.find_by(end_year: team_game["Season"])
      @team = Team.find_by(key: team_game["Team"])
      @opponent = Team.find_by(key: team_game["Opponent"])
      @teamseason = TeamSeason.find_by(team: @team, season: @season)
      @game = Game.find_by(global_game_id: team_game["GameID"])
      currentgame = TeamGame.find_or_initialize_by(global_game_id: team_game["StatID"])
      if currentgame
        currentgame.team = @team
        currentgame.opponent_id = @opponent.id
        currentgame.team_season = @teamseason
        currentgame.game = @game
        currentgame.team_key = @team.key
        currentgame.is_game_over = game["IsGameOver"]
        currentgame.wins = team_game["Wins"]
        currentgame.losses = team_game["Losses"]
        currentgame.conference_wins = team_game["ConferenceWins"]
        currentgame.conference_losses = team_game["ConferenceLosses"]
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
        currentgame.possessions = currentgame.field_goals_attempted - currentgame.offensive_rebounds + currentgame.turnovers + ( 0.42 * currentgame.free_throws_attempted)
        # currentgame.opponent_game_id = @game.team_games.find_by(opponent_key: team_game["Team"]).id
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
     TeamGame.all.each do |team_game|
      if team_game.game && team_game.team && team_game.opponent_id
        @game = team_game.game
        @opponent_game = @game.team_games.find_by(opponent_key: team_game.team.key)
        team_game.opponent_game_id = @opponent_game.id
        team_game.save
      end
    end
    puts x.to_s + " games added or updated."
   
  end

  task quick_task: :environment do
    z = 0
      TeamGame.all.each do |team_game|
      if team_game.game && team_game.team && team_game.opponent_id
        @game = team_game.game
        @opponent_game = @game.team_games.find_by(opponent_key: team_game.team_key)
        if @opponent_game
          team_game.opponent_game_id = @opponent_game.id
        else
          z += 1
        end
        team_game.save
      end
    end
    puts z.to_s + " opponent games with errors."
    puts x.to_s + " games added or updated."
  end
end