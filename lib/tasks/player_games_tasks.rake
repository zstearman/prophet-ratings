namespace :player_games_tasks do
  desc "TODO"
  task get_player_games: :environment do
    date = '2017-NOV-10'
    uri = URI('https://api.fantasydata.net/v3/cbb/stats/JSON/PlayerGameStatsByDate/' + date)
    
    request = Net::HTTP::Get.new(uri.request_uri)
    # Request headers
    # Currently using trial subscription key
    request['Ocp-Apim-Subscription-Key'] = '8b5aef100e21492e869155a34e58e245'
    # Request body
    request.body = ""
    
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end
    x = 0
    y = 0
    @player_games =  JSON.parse response.body
    @player_games.each do |game|
      @game = PlayerGame.find_or_initialize_by(stat_id: game["StatID"])
      @player = Player.find_by(global_player_id: game["PlayerID"])
      @totalgame = Game.find_by(global_game_id: game["GameID"])
      @team = Team.find_by(key: game["Team"])
      @teamgame = TeamGame.find_by(game: @totalgame, team: @team)
      @game.global_player_game_id = game["StatID"]
      @game.name = game["Name"]
      @game.game = @totalgame
      @game.player = @player
      @game.team_game = @teamgame
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
      if @game.save
        x += 1
      end
    end
    # @hierarchy.each do |conference|
    #   @conference = Conference.find_or_initialize_by(global_conference_id: conference["ConferenceID"])
    #   conference["Teams"].each do |team|
    #     @team = Team.find_by(key: team["Key"])
    #     if @team
    #       @team.conference = @conference
    #       if @team.save
    #         x += 1
    #       end
    #     end
    #   end
    #   @conference.name = conference["Name"]
    #   if @conference.save
    #     y += 1
    #   end
    # end
    puts x.to_s + " player games added or updated."
  end

end
