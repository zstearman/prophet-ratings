class AddIndexToTeamSeasonTeamId < ActiveRecord::Migration[5.1]
  def change
    add_index :team_seasons, [:team_id, :season_id]
  end
end
