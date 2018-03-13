class TeamsController < ApplicationController
  before_action :admin_user, only: [:new, :edit, :create, :update, :destroy]
  
  def new
    @team = Team.new()
  end

  def edit
  end

  def create
  end

  def index
    @teams = Team.all
  end

  def update
  end

  def destroy
  end
  
  def show
    @team = Team.find(params[:id])
  end
  
  private
    def admin_user
      redirect_to(root_url) unless current_user.try(:admin?)
    end
end
