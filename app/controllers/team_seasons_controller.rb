class TeamSeasonsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    @team_seasons = TeamSeason.order("#{sort_column} #{sort_direction}")
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
end
