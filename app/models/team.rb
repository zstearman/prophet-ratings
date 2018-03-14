class Team < ApplicationRecord
    validates :school, presence: true, uniqueness: { case_sensitive: false }
    
    def combined_name
      "#{school + name }"
    end
    
end
