class UsersController < ApplicationController

  def index
    @developers = Developers.all if current_user.is_admin?
  end

  def dashboard
    @current_user = current_user
    if current_user.is_admin?
      @developers = params[:search].blank? ? Developer.all : Developer.search(params[:search])
    else
      @projects = params[:search].blank? ? current_user.projects.all : current_user.projects.search(params[:search])
    end
  end

  def projects
    current_user.is_admin? ? Admin.find(current_user.id).projects : Developer.find(current_user.id).projects
  end
end
