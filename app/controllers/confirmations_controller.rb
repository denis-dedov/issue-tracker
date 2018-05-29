class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_confirmation_path_for(resource_name, resource)
    return root_path unless resource.sign_in_count == 0

    sign_in(resource)
    flash[:notice] << " #{t(:set_up_password)}"
    edit_profile_path
  end
end
