class AddSeasonToTeamGames < ActiveRecord::Migration[5.1]
  def change
    add_column :team_games, :season, :integer
  end
end
