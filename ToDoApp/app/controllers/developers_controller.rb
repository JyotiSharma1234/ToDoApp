class DevelopersController < ApplicationController
  before_action :load_developer, only: [:show, :edit, :update, :destroy]
  def index
    @developers = params[:search].blank? ? Developer.all : Developer.search(params[:search])
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)
    @developer.password = '123456'
    if @developer.save
      redirect_to @developer
    else
      p @developer.errors
      render 'new'
    end
  end

  def update
    if @developer.update(developer_params)
      redirect_to developers_path
    else
      p @developer.errors
      render 'edit'
    end
  end

  def destroy
    @developer.destroy

    redirect_to developers_path
  end

  private
  def developer_params
    params.require(:developer).permit(:name, :email, :address)
  end

  def load_developer
    @developer = Developer.find_by(id: params[:id])
  end
end
