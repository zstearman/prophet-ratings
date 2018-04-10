class AddSeasonToSeason < ActiveRecord::Migration[5.1]
  def change
    add_column :seasons, :season, :integer
  end
end
