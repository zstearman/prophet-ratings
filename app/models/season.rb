class Season < ApplicationRecord
  has_many :team_seasons
  validates :start_year, presence: true, uniqueness: true
  validates :end_year, presence: true, uniqueness: true
  validates :current, presence: true
end
