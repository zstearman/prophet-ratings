class CreateTeamGames < ActiveRecord::Migration[5.1]
  def change
    create_table :team_games do |t|

      t.timestamps
      t.references :team_season, foreign_key: true
      t.references :team, foreign_key: true
      t.references :game, foreign_key: true
      t.integer :wins
      t.integer :losses
      t.integer :conference_wins
      t.integer :conference_losses
      t.decimal :possessions
      t.integer :opponent_id
      t.string :opponent_key
      t.date :day
      t.datetime :date_time
      t.boolean :home
      t.datetime :updated
      t.integer :season_type
      t.integer :field_goals_made
      t.integer :field_goals_attempted
      t.decimal :field_goals_percentage
      t.decimal :effective_field_goal_percentage
      t.integer :two_pointers_made
      t.integer :two_pointers_attempted
      t.decimal :two_pointers_percentage
      t.integer :three_pointers_made
      t.integer :three_pointers_attempted
      t.decimal :three_pointers_percentage
      t.integer :free_throws_made
      t.integer :free_throws_attempted
      t.decimal :free_throws_percentage
      t.integer :offensive_rebounds
      t.integer :defensive_rebounds
      t.integer :rebounds
      t.integer :assists
      t.integer :steals
      t.integer :blocked_shots
      t.integer :turnovers
      t.integer :personal_fouls
      t.integer :points
      t.decimal :true_shooting_attempts
      t.decimal :true_shooting_percentage
    end
  end
end
