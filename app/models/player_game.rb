class PlayerGame < ApplicationRecord
  belongs_to :game
  belongs_to :player
  belongs_to :team_game
  validates :player, presence: true 
  validates :game, presence: true
end
