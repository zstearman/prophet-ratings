class AddIndexToOpponentKeyInTeamGames < ActiveRecord::Migration[5.1]
  def change
    add_index :team_games, :opponent_key
  end
end
