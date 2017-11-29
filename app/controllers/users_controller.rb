class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Crowdfunding Rails App! Start a project today!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  
      def user_params
        params.require(:user).permit(:name, :email, :street, :city, :state,                               :zip, :password, :password_confirmation)
      end

end
