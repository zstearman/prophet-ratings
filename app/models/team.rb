class Team < ApplicationRecord
    has_and_belongs_to_many :user
    validates :school, presence: true, uniqueness: { case_sensitive: false }
end
