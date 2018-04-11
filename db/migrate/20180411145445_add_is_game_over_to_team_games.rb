class AddIsGameOverToTeamGames < ActiveRecord::Migration[5.1]
  def change
    add_column :team_games, :is_game_over, :boolean
  end
end
