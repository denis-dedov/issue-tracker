class UsersController < ApplicationController
  before_action :check_access

  def index
    @users = User.where(is_admin: false)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private

  def check_access
    redirect_to root_url unless current_user.is_admin?
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :is_manager)
  end
end
