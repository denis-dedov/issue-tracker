class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_registration_step, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def check_registration_step
    return if current_user.registration_finished?

    redirect_to profile_path, notice: t(:set_up_password)
  end
end
