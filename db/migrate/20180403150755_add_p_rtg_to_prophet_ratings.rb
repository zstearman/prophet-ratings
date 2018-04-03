class AddPRtgToProphetRatings < ActiveRecord::Migration[5.1]
  def change
    add_column :prophet_ratings, :p_rtg, :decimal
  end
end
