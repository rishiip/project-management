class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_filter :project_params, only: [:create]

  def index
    if current_user.admin?
      @projects = Project.includes(:users, :todos => [:users_todo => [:user]])
    else
      @projects = current_user.projects.includes(:users, :todos => [:users_todo => [:user]])
    end
  end

  def create
    project = Project.create(project_params)

    render json: project
  end

  def assign_project
    project = Project.find_by_id(params[:id])
    project.users << User.find_by_id(params[:user_id])
    project.save!

    render json: project
  end

  private

  def project_params
    params.require(:project).permit!
  end
end
