class Team < ApplicationRecord
    validates :school, presence: true, uniqueness: { case_sensitive: false }
    has_many :team_seasons
    has_many :team_games
    has_many :players
    has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
    has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id'
    belongs_to :conference
    
    def combined_name
      "#{school + name }"
    end
    
end
