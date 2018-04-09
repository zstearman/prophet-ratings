class AddDataToPlayerGames < ActiveRecord::Migration[5.1]
  def change
    add_column :player_games, :stat_id, :integer, index: true
    add_reference :player_games, :team, foreign_key: true
    add_column :player_games, :season_type, :integer
    add_reference :player_games, :team_season, foreign_key: true
    add_column :player_games, :position, :string
    add_column :player_games, :injury_status, :string
    add_column :player_games, :injury_body_part, :string
    add_column :player_games, :injury_start_date, :date
    add_column :player_games, :injury_notes, :string
    add_column :player_games, :global_team_id, :integer
    add_column :player_games, :global_game_id, :integer
    add_column :player_games, :global_opponent_id, :integer
    add_reference :player_games, :game, foreign_key: true
    add_reference :player_games, :team_game, foreign_key: true
    add_column :player_games, :minutes, :integer
    add_column :player_games, :field_goals_made, :integer
    add_column :player_games, :field_goals_attempted, :integer
  end
end
