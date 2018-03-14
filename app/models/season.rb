class Season < ApplicationRecord
  validates :start_year, presence: true, uniqueness: true
  validates :end_year, presence: true, uniqueness: true
  validates :current, presence: true
end
