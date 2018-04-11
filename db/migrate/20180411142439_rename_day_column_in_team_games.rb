class RenameDayColumnInTeamGames < ActiveRecord::Migration[5.1]
  def change
    rename_column :team_games, :day, :date
  end
end
