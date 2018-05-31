class IssuesController < ApplicationController
  before_action :check_user_role, only: [:create, :destroy]

  def index
    @issues = current_user.issues
      .filter(filter_params)
      .order(created_at: :desc)
      .page(params[:page])
      .includes(:owner, :assignee)
  end

  def new
    @issue = Issue.new
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
    current_user.issues.find(params[:id]).destroy

    redirect_to issues_path
  end

  private

  def check_user_role
    redirect_to issues_path if current_user.is_manager?
  end

  def issue_params
    list = [:title, :description, :status, :assignee_id].take(current_user.is_regular? ? 2 : 4)

    params.require(:issue).permit(list)
  end

  def filter_params
    params.permit(:status)
  end

  def validate
    return unless current_user.is_manager?

    if @issue.assignee_id_changed? && !@issue.assignee.in?([current_user, nil])
      @issue.errors.add(:assignee, :reassign_error)
    end

    if @issue.status_changed? && @issue.assignee != current_user
      @issue.errors.add(:status, :change_error)
    end
  end
end
