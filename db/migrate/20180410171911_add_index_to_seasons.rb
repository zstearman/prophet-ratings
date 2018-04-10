class AddIndexToSeasons < ActiveRecord::Migration[5.1]
  def change
    add_index :seasons, :season
  end
end
