class AddApRankToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :ap_rank, :integer
  end
end
