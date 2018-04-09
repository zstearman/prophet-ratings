class AddPlayerToPlayerSeasons < ActiveRecord::Migration[5.1]
  def change
    add_reference :player_games, :player, foreign_key: true
  end
end
