class UsersController < ApplicationController
  def new
    @user = User.new()
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params.merge(:expiration_date => Date.today,
                                       :account_level => params[:plan_id]))
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end
  
  private
    
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation,
                                   :account_level, :expiration_date)
    end
end
