class TasksController < ApplicationController
  before_action :load_task, only: [:show, :edit, :update, :destroy]
  def index
    project_ids = current_user.projects.pluck(:id)
    @tasks = Task.where(project_id: project_ids)
  end

  def new
    @task = Task.new
    @projects = current_user.projects
    @developers = Developer.all
  end

  def create
    @task = Task.new task_params
    if @task.save
      flash[:success] = "Task created successfully" 
      redirect_to tasks_path
    else
      p @task.errors
      render 'new'
    end
  end

  def edit
    @projects = current_user.projects
    @developers = Developer.all
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      p @task.errors
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  def start
    @task = Task.find(params['task_id'])
    @task.update(status: 'InProgress')
    redirect_to tasks_path
  end

  def finish
    @task = Task.find(params['task_id'])
    @task.update(status: 'Done', end_date: Date.today)
    redirect_to tasks_path
  end
  private
  def load_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :start_date,:description, :project_id, :developer_id)
          .merge(params.permit(:project_id, :developer_id))
  end

end
