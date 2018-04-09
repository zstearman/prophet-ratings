class AddIndexToTeamSeasonSeason < ActiveRecord::Migration[5.1]
  def change
    add_index :seasons, :end_year
    add_index :games, :global_game_id
  end
end
