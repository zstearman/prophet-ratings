class Team < ApplicationRecord
    validates :school, presence: true, uniqueness: { case_sensitive: false }
    has_many :team_seasons
    
    def combined_name
      "#{school + name }"
    end
    
end
