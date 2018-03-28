class AddIndexToTeamsKey < ActiveRecord::Migration[5.1]
  def change
    add_index :teams, :key, unique: true
    add_column :team_seasons, :three_pointers_per_field_goal_attempted, :decimal
  end
end
