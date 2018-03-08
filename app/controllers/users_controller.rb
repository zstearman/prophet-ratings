class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update, :show]
  
  def new
    @user = User.new()
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params.merge( :expiration_date => Date.today + 7.days))
    if @user.save
      log_in @user
      flash[:success] = "Thank you for signing up for Prophet Ratings!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
    
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation,
                                   :account_level, :expiration_date)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in first."
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
