module IssuesHelper
  def supress_status_change?
    return false if current_user.is_admin?

    current_user.is_regular? || @issue.assignee != current_user
  end

  def assignee_options
    current_user.is_admin? ? User.assignees : [ current_user ]
  end

  def supress_assignee_change?
    return false if current_user.is_admin?

    current_user.is_regular? || !@issue.assignee.in?([current_user, nil])
  end
end
