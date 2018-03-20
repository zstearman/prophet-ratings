class AddIndexToGameGlobalGameId < ActiveRecord::Migration[5.1]
  def change
    add_index :games, [:global_game_id, :home_team, :away_team]
  end
end
