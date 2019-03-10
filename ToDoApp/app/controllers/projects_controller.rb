class ProjectsController < ApplicationController
  before_action :load_project, only: [:show, :edit, :update, :destroy]
  def index
    if current_user.is_admin?
      @projects = params[:search].blank? ? current_user.projects : @current_user.projects.search(params[:search])
    else current_user.is_developer?
      @projects = params[:search].blank? ? current_user.projects.all : current_user.projects.search(params[:search])
    end
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build project_params
    @project.developer_ids = params[:project][:developer_ids].reject(&:empty?) if params[:project][:developer_ids]
    if @project.save
      flash[:success] = "project created successfully" 
      redirect_to projects_path
    else
      p @project.errors
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path
    else
      p @project.errors
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private
  def load_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :start_date,:technology)
  end
end
