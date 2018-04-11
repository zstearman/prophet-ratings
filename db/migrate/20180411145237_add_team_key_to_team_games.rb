class AddTeamKeyToTeamGames < ActiveRecord::Migration[5.1]
  def change
    add_column :team_games, :team_key, :string, index: true
  end
end
