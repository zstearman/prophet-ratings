class AddOpponentGameIdToTeamGames < ActiveRecord::Migration[5.1]
  def change
    add_column :team_games, :opponent_game_id, :integer
  end
end
