class TeamSeason < ApplicationRecord
  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_season_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_season_id'
  belongs_to :season
  belongs_to :team
  has_many :game
  validates :team_id, presence: true
  validates :season_id, presence: true
end
