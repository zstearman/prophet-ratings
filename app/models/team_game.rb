class TeamGame < ApplicationRecord
  belongs_to :team_season
  belongs_to :team
  belongs_to :game
  has_many :player_games
  validates :game, :presence => true
  validates :opponent_id, :presence => true
end
