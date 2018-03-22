class AddAssistsPercentageToTeamSeasons < ActiveRecord::Migration[5.1]
  def change
    add_column :team_seasons, :assists_percentage, :decimal
    remove_column :team_seasons, :assits_percentage
  end
end
