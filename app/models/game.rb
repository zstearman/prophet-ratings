class Game < ApplicationRecord
  attr_accessor :away_margin_of_victory, :margin_of_victory, :outcome
  belongs_to :away_team_season, :class_name => 'TeamSeason', :foreign_key => 'away_team_season_id'
  belongs_to :home_team_season, :class_name => 'TeamSeason', :foreign_key => 'home_team_season_id'
  belongs_to :home_team, :class_name => 'Team', :foreign_key => 'home_team_id'
  belongs_to :away_team, :class_name => 'Team', :foreign_key => 'away_team_id'
  
  def away_margin_of_victory
    @away_margin_of_victory = self.away_score - self.home_score
  end
  
  def margin_of_victory(team)
    if team == self.home_team
      @margin_of_victory = self.home_score - self.home_score
    elsif team == self.away_team
      @margin_of_victory = self.away_score - self.home_score
    else
      return nil
    end
  end
  
  def outcome(team)
    if team == home_team
      if home_score > away_score
        @outcome = "W, " + home_score.to_s + "-" + away_score.to_s
      else
        @outcome = "L, " + home_score.to_s + "-" + away_score.to_s
      end
    elsif team == away_team
      if away_score > home_score
        @outcome = "W, " + away_score.to_s + "-" + home_score.to_s
      else
        @outcome = "L, " + away_score.to_s + "-" + home_score.to_s
      end
    else
      return nil
    end
  end
end
