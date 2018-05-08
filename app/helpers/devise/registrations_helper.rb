module Devise::RegistrationsHelper
  def profile_path
    current_user.is_admin? ? user_path(@user) : registration_path(@user)
  end

  def page_title
    current_user.is_admin? ? "Edit #{@user.to_s.humanize}" : 'My Profile'
  end
end
