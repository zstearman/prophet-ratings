class CreatePlayerGames < ActiveRecord::Migration[5.1]
  def change
    create_table :player_games do |t|

      t.timestamps
      t.integer :global_player_id, index: true
      t.integer :global_player_game_id, index: true
      t.string :name
      
    end
  end
end
