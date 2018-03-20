class AddHomeAndAwayTeamGamesToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :home_team_season_id, :integer, index: true
    add_column :games, :away_team_season_id, :integer, index: true
    add_foreign_key :games, :team_seasons, column: :home_team_season_id
    add_foreign_key :games, :team_seasons, column: :away_team_season_id
  end
end
