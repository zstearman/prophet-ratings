namespace :players_tasks do
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
        currentplayer.high_school = player["HightSchool"]
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
