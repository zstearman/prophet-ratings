class TeamSeason < ApplicationRecord
  belongs_to :team
  belongs_to :season
  validates :team_id, presence: true
  validates :season_id, presence: true
end
