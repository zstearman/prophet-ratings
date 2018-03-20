class TeamsController < ApplicationController
  before_action :admin_user, only: [:new, :edit, :create, :update, :destroy]
  helper_method :sort_column, :sort_direction
  
  def new
    @team = Team.new()
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "New team has been added to database!"
      redirect_to teams_path
    else
      render 'new'
    end
  end

  def index
    @teams = Team.order("#{sort_column} #{sort_direction}")
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      flash[:success] = "Team info has been updated."
      redirect_to teams_path
    else
      render 'edit'
    end
  end

  def destroy
    Team.find(params[:id]).destroy
    flash[:success] = "Team deleted!"
    redirect_to teams_url
  end
  
  def show
    @team = Team.find(params[:id])
    @season = @team.team_seasons.find_by(season: current_season)
    @home_games = @season.home_games.all
    @away_games = @season.away_games.all
    @games = @home_games + @away_games
    @games.sort_by! &:date
  end
  
  private
    def admin_user
      redirect_to(root_url) unless current_user.try(:admin?)
    end
    
    def team_params
      params.require(:team).permit(:school, :name, :active, :ap_rank, 
                                   :conference_id, :team_logo_url)
    end
    
    def sortable_columns
      ["school", "name", "ap_rank"]
    end
    
    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : "school"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
