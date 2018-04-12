class AddMoreStuffToPlayerGames < ActiveRecord::Migration[5.1]
  def change
    add_column :player_games, :free_throws_made, :integer
    add_column :player_games, :free_throws_attempted, :integer
    add_column :player_games, :free_throws_percentage, :decimal
    add_column :player_games, :offensive_rebounds, :integer
    add_column :player_games, :defensive_rebounds, :integer
    add_column :player_games, :rebounds, :integer
    add_column :player_games, :assists, :integer
    add_column :player_games, :steals, :integer
    add_column :player_games, :blocked_shots, :integer
    add_column :player_games, :turnovers, :integer
    add_column :player_games, :personal_fouls, :integer
    add_column :player_games, :points, :integer
    add_column :player_games, :true_shooting_attempts, :decimal
    add_column :player_games, :true_shooting_percentage, :decimal
  end
end
