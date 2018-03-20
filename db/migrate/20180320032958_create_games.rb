class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.references :season, foreign_key: true
      t.integer :season_type
      t.string :status
      t.string :away_team
      t.string :home_team
      t.integer :away_score
      t.integer :home_score
      t.datetime :updated
      t.string :period
      t.decimal :point_spread
      t.decimal :over_under
      t.integer :away_money_line
      t.integer :home_money_line
      t.integer :tournament_id
      t.string :bracket
      t.integer :round
      t.integer :away_seed
      t.integer :home_seed
      t.integer :global_game_id
      t.integer :away_previous_global_game_id
      t.integer :home_previous_global_game_id
      t.integer :tournament_display_order
      t.timestamps
    end
  end
end
