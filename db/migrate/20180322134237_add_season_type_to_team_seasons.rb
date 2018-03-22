class AddSeasonTypeToTeamSeasons < ActiveRecord::Migration[5.1]
  def change
    add_column :team_seasons, :season_type, :integer
    add_column :team_seasons, :global_team_season_id, :integer
    add_column :games, :date_time, :datetime
    add_column :teams, :global_team_id, :integer, index: true
    remove_column :teams, :ap_rank
    remove_column :games, :home_team
    remove_column :games, :away_team
    add_column :games, :home_team_key, :string
    add_column :games, :away_team_key, :string
    add_column :games, :possessions, :integer
    add_column :games, :global_away_team_id, :integer
    add_column :games, :global_home_team_id, :integer
    add_column :games, :location_type, :string
    add_column :games, :location, :string
    add_index :games, :date
  end
end
