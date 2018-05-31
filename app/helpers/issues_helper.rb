module IssuesHelper
  def supress_attr_change?
    return false if current_user.is_admin?

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

  def user_link(issue, role=:owner)
    return unless user = issue.send(role)

    current_user.is_admin? ? link_to(user.to_s, edit_user_path(user)) : user.to_s
  end

  def delete_link(issue, type=:link)
    super(issue, type)
  end

  def status_options(default={})
    opts = Issue.statuses.with_defaults(default).to_a.map(&:reverse)
    options_for_select(opts, params[:status])
  end
end
