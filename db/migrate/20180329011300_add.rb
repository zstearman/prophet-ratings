class Add < ActiveRecord::Migration[5.1]
  def change
    add_column :team_seasons, :free_throws_per_field_goal_attempted, :decimal
    add_index :team_seasons, :global_team_season_id, unique: true
    add_index :team_seasons, :school
  end
end
