module UsersHelper
  def delete_link(user, type=:link)
    super(user, type)
  end

  def delete_button
    delete_link(@user, :button) if current_user.is_admin? && current_user != @user
  end
end
