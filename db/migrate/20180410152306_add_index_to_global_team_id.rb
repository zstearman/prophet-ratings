class AddIndexToGlobalTeamId < ActiveRecord::Migration[5.1]
  def change
    add_index :teams, :global_team_id
  end
end
