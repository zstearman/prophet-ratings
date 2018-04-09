class AddMoreDataToPlayerGames < ActiveRecord::Migration[5.1]
  def change
    add_column :player_games, :home_or_away, :string
    add_column :player_games, :field_goals_percentage, :decimal
    add_column :player_games, :effective_field_goals_percentage, :decimal
    add_column :player_games, :two_pointers_made, :integer
    add_column :player_games, :two_pointers_attempted, :integer
    add_column :player_games, :two_pointers_percentage, :decimal
    add_column :player_games, :three_pointers_made, :integer
    add_column :player_games, :three_pointers_attempted, :integer
    add_column :player_games, :three_pointers_percentage, :decimal
  end
end
