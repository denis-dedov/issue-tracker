class IssuesController < ApplicationController
  before_action :check_user_role, only: [:create, :destroy]

  def index
    @issues = current_user.issues.order(created_at: :desc).page params[:page]
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.owner = current_user

    if @issue.save
      redirect_to issues_path
    else
      render 'new'
    end
  end

  def edit
    @issue = current_user.issues.find(params[:id])
  end

  def update
    @issue = current_user.issues.find(params[:id])
    @issue.assign_attributes(issue_params)
    validate

    if @issue.errors.blank? && @issue.save
      redirect_to issues_path
    else
      render 'edit'
    end
  end

  def destroy
    @issue = current_user.issues.find(params[:id])
    @issue.destroy

    redirect_to issues_path
  end

  private

  def check_user_role
    redirect_to issues_path if current_user.is_manager?
  end

  def issue_params
    params_list = [:title, :description]
    params_list += [:status, :assignee_id] unless current_user.is_regular?
    params.require(:issue).permit(params_list)
  end

  def validate
    return unless current_user.is_manager?

    if @issue.assignee_id_changed? && !@issue.assignee.in?([current_user, nil])
      @issue.errors.add(:assignee, 'You are not abble to reassign the issue')
    end

    if @issue.status_changed? && @issue.assignee != current_user
      @issue.errors.add(:status, 'You can change the status only for issues assigned to you')
    end
  end
end
