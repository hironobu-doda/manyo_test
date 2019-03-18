class UsersController < ApplicationController
  skip_before_action :login_required
  def new
    redirect_to user_path(current_user.id) if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if  @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render'new'
    end
  end

  def show
    redirect_to user_path(current_user.id) if current_user.id != params[:id].to_i
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
