module ApplicationHelper
  def error_messages(resourse)
    return if resourse.errors.blank?

    content_tag(:div, class: 'alert alert-danger') do
      concat resourse.errors.full_messages.map{ |msg| content_tag(:li, msg) }.join.html_safe
    end
  end

  def alert
    return super if user_signed_in? || @user.errors.blank?

    @user.errors.full_messages.join("\n") unless user_signed_in?
  end

  def delete_link(resourse, type)
    link_to 'Delete', resourse, method: :delete, data: { confirm: 'Are you sure?' },
      class: ('btn btn-danger' if type == :button)
  end
end
