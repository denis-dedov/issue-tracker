module Devise::RegistrationsHelper
  def profile_path
    current_user.is_admin? ? user_path(@user) : registration_path(@user)
  end

  def page_title
    current_user.id == @user.id ? 'My Profile' : "Edit #{@user.to_s.humanize}"
  end
end
