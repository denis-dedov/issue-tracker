module ApplicationHelper
  def error_messages(resourse)
    return if resourse.errors.blank?

    content_tag(:div, class: 'alert alert-danger') do
      concat resourse.errors.messages.values.flatten.map { |msg| content_tag(:li, msg) }.join.html_safe
    end
  end
end
