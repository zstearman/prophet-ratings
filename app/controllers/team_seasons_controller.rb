class TeamSeasonsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :logged_in_user
  
  def index
    @team_seasons = TeamSeason.order("#{sort_column} #{sort_direction}")
  end
  
  def stats
    @team_seasons = TeamSeason.all
    
  end
  
  private
    def sortable_columns
      ["school", "wins"]
    end
    
    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : "wins"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
    
    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "Please log in first."
    #     redirect_to login_url
    #   end
    # end

end
