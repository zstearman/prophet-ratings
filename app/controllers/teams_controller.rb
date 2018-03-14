class TeamsController < ApplicationController
  before_action :admin_user, only: [:new, :edit, :create, :update, :destroy]
  
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
    @teams = Team.all
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
  end
  
  private
    def admin_user
      redirect_to(root_url) unless current_user.try(:admin?)
    end
    
    def team_params
      params.require(:team).permit(:school, :name, :active, :ap_rank, 
                                                            :team_logo_url)
    end
end
