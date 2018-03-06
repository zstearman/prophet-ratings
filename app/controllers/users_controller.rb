class UsersController < ApplicationController
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
  
  private
    
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation,
                                   :account_level, :expiration_date)
    end
end
