class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @projects = Project.includes(:todos)
    else
      @projects = current_user.projects.includes(:todos)
    end
  end
end
