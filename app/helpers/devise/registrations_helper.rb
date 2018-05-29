module Devise::RegistrationsHelper
  def form_path
    current_user.is_admin? ? user_path(@user) : profile_path
  end

  def page_title
    current_user == @user ? 'My Profile' : "User ##{@user.id}"
  end
end
