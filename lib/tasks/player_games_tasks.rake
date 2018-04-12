namespace :player_games_tasks do
  desc "TODO"
  task get_player_games: :environment do
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
      uri = URI('https://api.fantasydata.net/v3/cbb/stats/JSON/PlayerGameStatsByDate/' + current_date.to_s)
      
      request = Net::HTTP::Get.new(uri.request_uri)
      # Request headers
      # Currently using trial subscription key
      request['Ocp-Apim-Subscription-Key'] = '8b5aef100e21492e869155a34e58e245'
      # Request body
      request.body = ""
      
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          http.request(request)
      end
      @player_games =  JSON.parse response.body
      @player_games.each do |game|
        @team = Team.find_by(global_team_id: game["GlobalTeamID"])
        if @team
          @game = PlayerGame.find_or_initialize_by(stat_id: game["StatID"])
          @player = Player.find_by(global_player_id: game["PlayerID"])
          @totalgame = Game.find_by(global_game_id: game["GlobalGameID"])
          @teamgame = TeamGame.find_by(game: @totalgame, team: @team)
          @game.global_player_game_id = game["StatID"]
          @game.name = game["Name"]
          @game.game = @totalgame
          @game.player = @player
          @game.team_game = @teamgame
          @game.team_id= @team.id
          @game.season_type = game["SeasonType"]
          @game.global_player_id = game["GlobalPlayerID"]
          @game.home_or_away = game["HomeOrAway"]
          @game.position = game["Position"]
          @game.injury_status = game["InjuryStatus"]
          @game.injury_body_part = game["InjuryBodyPart"]
          # Add injury start date here
          @game.injury_notes = game["InjuryNotes"]
          @game.minutes = game["Minutes"]
          @game.field_goals_made = game["FieldGoalsMade"]
          @game.field_goals_attempted = game["FieldGoalsAttempted"]
          @game.field_goals_percentage = game["FieldGoalsPercentage"]
          @game.effective_field_goals_percentage = game["EffectiveFieldGoalsPercentage"]
          @game.two_pointers_made = game["TwoPointersMade"]
          @game.two_pointers_attempted = game["TwoPointersAttempted"]
          @game.two_pointers_percentage = game["TwoPointersPercentage"]
          @game.three_pointers_made = game["ThreePointersMade"]
          @game.three_pointers_attempted = game["ThreePointersAttempted"]
          @game.three_pointers_percentage = game["ThreePointersPercentage"]
          @game.free_throws_made = game["FreeThrowsMade"]
          @game.free_throws_attempted = game["FreeThrowsAttempted"]
          @game.free_throws_percentage = game["FreeThrowsPercentage"]
          @game.offensive_rebounds = game["OffensiveRebounds"]
          @game.defensive_rebounds = game["DefensiveRebounds"]
          @game.rebounds = game["Rebounds"]
          @game.assists = game["Assists"]
          @game.steals = game["Steals"]
          @game.blocked_shots = game["BlockedShots"]
          @game.turnovers = game["Turnovers"]
          @game.personal_fouls = game["PersonalFouls"]
          @game.points = game["Points"]
          @game.true_shooting_attempts = game["TrueShootingAttempts"]
          @game.true_shooting_percentage = game["TrueShootingPercentage"]
          if @game.save
            x += 1
          end
        end
      end
      y += 1
      current_date += 1.day
      if y % 10 == 0
        puts x.to_s + " player games added over " + y.to_s + " days so far."
      end
    end
    puts x.to_s + " player games added or updated."
  end

end
