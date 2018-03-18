class Conference < ApplicationRecord
  has_many :teams
  validates :name, presence: true
end
