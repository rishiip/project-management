class TodosController < ApplicationController
  before_action :authenticate_user!
  before_filter :todo_params, only: [:create]

  def create
    @todo = Todo.create(params[:todo])
    assign_project_to_user

    respond_to do |format|
      format.json
    end
  end

  private
  def assign_project_to_user
    user = User.find_by_id(params[:user_id])
    user.todos << @todo
    user.projects << @todo.project unless user.projects.include?(@todo.project)
    user.save!
  end

  def todo_params
    params.require(:todo).permit!
  end
end
