class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to dashboard_path
    end
  end

  def about
  end

  def contact
  end
  
  def plan
  end
  
  def coming_soon
    if logged_in?
      redirect_to dashboard_path
    end
  end
  
  def dashboard
    # Attepmt to order by a foreign table is not successful
    # @team_seasons = TeamSeason.includes(:team).order("team.ap_rank desc")
    @team_seasons = TeamSeason.where.not(p_rtg: nil).order(p_rtg: :desc).limit(25)
    @games = Game.where(date: '16/03/2018').limit(10)
  end
end
