class Game < ApplicationRecord
  belongs_to :away_team_season, :class_name => 'TeamSeason', :foreign_key => 'away_team_season_id'
  belongs_to :home_team_season, :class_name => 'TeamSeason', :foreign_key => 'home_team_season_id'
  belongs_to :home_team, :class_name => 'Team', :foreign_key => 'home_team_id'
  belongs_to :away_team, :class_name => 'Team', :foreign_key => 'away_team_id'
end
