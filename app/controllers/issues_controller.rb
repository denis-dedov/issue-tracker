class IssuesController < ApplicationController
  before_action :check_user_role, only: [:create, :destroy]

  def index
    @issues = current_user.issues.order(created_at: :desc)
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.owner = current_user
    validate

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

    if @issue.save
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
    params.require(:issue).permit(:title, :description, :status, :assignee_id)
  end
end
