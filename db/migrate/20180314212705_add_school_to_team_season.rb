class AddSchoolToTeamSeason < ActiveRecord::Migration[5.1]
  def change
    add_column :team_seasons, :school, :string
    add_column :team_seasons, :ap_rank, :integer
  end
end
