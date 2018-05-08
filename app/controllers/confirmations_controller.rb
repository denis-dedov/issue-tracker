class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_confirmation_path_for(resource_name, resource)
    sign_in(User.where(confirmation_token: params[:confirmation_token]).first, scope: :user)

    edit_user_registration_path
  end
end
