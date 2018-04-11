namespace :players_tasks do
  
  desc "Get players from FantasyData.com"
  task get_players: :environment do
    x = 0
    y = 0
    Team.all.each do |team|
      if team.key == "UMKC"
        team.key = "MKC"
      end
      uri = URI('https://api.fantasydata.net/v3/cbb/stats/JSON/Players/' + team.key)
      request = Net::HTTP::Get.new(uri.request_uri)
      # Request headers
      # Currently using trial subscription key
      request['Ocp-Apim-Subscription-Key'] = 'ce3dce505f5540688889d2f547550d28'
      # Request body
      request.body = ""
      
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
      end
      @players =  JSON.parse response.body
      @players.each do |player|
        currentplayer = Player.find_or_initialize_by(global_player_id: player["PlayerID"])
        if currentplayer
          currentplayer.team = team
          currentplayer.first_name = player["FirstName"]
          currentplayer.last_name = player["LastName"]
          currentplayer.jersey = player["Jersey"]
          currentplayer.position = player["Position"]
          currentplayer.year = player["Class"]
          currentplayer.height = player["Height"]
          currentplayer.weight = player["Weight"]
          currentplayer.birth_city = player["BirthCity"]
          currentplayer.birth_state = player["BirthState"]
          currentplayer.high_school = player["HighSchool"]
          if currentplayer.save
            x += 1
          else
            currentplayer.errors.full_messages.each do |msg|
              puts currentplayer
              puts msg
            end
          end
        end
      end
      y += 1
      if y % 50 == 0
        puts x.to_s + " players added or updated on " + y.to_s + " teams so far."
      end 
    end
    puts x.to_s + " players added or updated on " + y.to_s + " teams."
  end
  
  desc "TODO"
  task players_json: :environment do
  x = 0
    @player = JSON.parse File.read(Rails.root.join('app', 'assets', 'jsons', 'Player.2018.json'))
    @player.each do |player|
      @team = Team.find_by(key: player["Team"])
      currentplayer = Player.find_or_initialize_by(global_player_id: player["PlayerID"])
      if currentplayer
        currentplayer.team = @team
        currentplayer.first_name = player["FirstName"]
        currentplayer.last_name = player["LastName"]
        currentplayer.jersey = player["Jersey"]
        currentplayer.position = player["Position"]
        currentplayer.year = player["Class"]
        currentplayer.height = player["Height"]
        currentplayer.weight = player["Weight"]
        currentplayer.birth_city = player["BirthCity"]
        currentplayer.birth_state = player["BirthState"]
        currentplayer.high_school = player["HighSchool"]
        if currentplayer.save
           x = x + 1
        else
          currentplayer.errors.full_messages.each do |msg|
            puts currentplayer
            puts msg
          end
        end
      else
        puts player
      end
    end
    puts x.to_s + " players added or updated."
  end

end
