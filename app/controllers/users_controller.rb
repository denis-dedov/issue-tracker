class UsersController < ApplicationController
  before_action :check_access

  def index
    @users = User.where(is_admin: false).page params[:page]
  end

  def edit
    @user = User.find(params[:id])

    render 'devise/registrations/edit'
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render 'devise/registrations/edit'
    end
  end

  def invite
    token = Devise.friendly_token
    User.create!(email: user_params[:email], password: token, confirmation_token: token)
    flash[:notice] = 'The invitation email was successfully sent'
  rescue
    flash[:alert] = 'The person has been already invited'
  ensure
    redirect_to users_path
  end

  def destroy
    User.find(params[:id]).destroy

    redirect_to users_path
  end

  private

  def check_access
    redirect_to root_url unless current_user.is_admin?
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :is_manager, :email)
  end
end
