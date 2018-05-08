class ConfirmationsController < Devise::ConfirmationsController
  # before_action :sign_in_confirmed_user

  private

  def sign_in_confirmed_user
    sign_in(User.where(confirmation_token: params[:confirmation_token]).first, scope: :user)

    edit_user_registration_path
  end

  def after_confirmation_path_for(resource_name, resource)
    sign_in(User.where(confirmation_token: params[:confirmation_token]).first, scope: :user)
    # new_registration_path(resource_name)
    edit_user_registration_path
  end

end
