class UsersController < ApplicationController

  def index
    @developers = Developers.all if current_user.is_admin?
  end

  def dashboard
    @current_user = current_user
    @developers = Developer.all if current_user.is_admin?
    @projects = get_projects
    project_ids = @projects.pluck(:id)
    @new_tasks_count = Task.where(project_id: project_ids, status: 'new').count
    @in_progress_tasks_count = Task.where(project_id: project_ids, status: 'InProgress').count
    @done_tasks_count = Task.where(project_id: project_ids, status: 'Done').count
  end

  def get_projects
    current_user.is_admin? ? Admin.find(current_user.id).projects : Developer.find(current_user.id).projects
  end
end
