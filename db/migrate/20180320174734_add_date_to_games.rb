class AddDateToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :date, :date
  end
end
