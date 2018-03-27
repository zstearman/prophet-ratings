class AddGlobalGameIdToTeamGame < ActiveRecord::Migration[5.1]
  def change
    add_column :team_games, :global_game_id, :integer
  end
end
