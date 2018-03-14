class CreateSeasons < ActiveRecord::Migration[5.1]
  def change
    create_table :seasons do |t|
      t.integer :start_year
      t.integer :end_year
      t.string :description
      t.date :regular_season_start_date
      t.date :post_season_start_date
      t.boolean :current

      t.timestamps
    end
  end
end
