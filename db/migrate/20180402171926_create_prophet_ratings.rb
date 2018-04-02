class CreateProphetRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :prophet_ratings do |t|
      t.references :team_season, foreign_key: true
      t.decimal :p_ortg
      t.decimal :p_drtg
      t.decimal :p_tempo
      t.timestamps
    end
  end
end
