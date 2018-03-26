class Player < ApplicationRecord
  has_many :player_games
  belongs_to :team
end
