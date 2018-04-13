class AddRankToPrtg < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :p_rtg, :decimal
    add_column :teams, :p_rank, :integer, index: true
    add_column :prophet_ratings, :p_rank, :integer, index: true
    add_column :prophet_ratings, :po_rank, :integer
    add_column :prophet_ratings, :pd_rank, :integer
    add_column :prophet_ratings, :pt_rank, :integer
  end
end
