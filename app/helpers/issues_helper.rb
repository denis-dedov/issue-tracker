module IssuesHelper
  def supress_attr_change?
    current_user.is_regular? || !@issue.assignee.in?([current_user, nil])
  end

  def assignee_options
    return User.assignees if current_user.is_admin?

    [ @issue.assignee.in?([current_user, nil]) ? current_user : @issue.assignee ]
  end

  def submit_title
    @issue.new_record? ? 'Create' : 'Update'
  end

  def timestamps_info(attr, format)
    content_tag(:i, [attr[0..-4].capitalize, @issue.send(attr).to_s(format)].join(': '))
  end
end
