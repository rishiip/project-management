class TodosController < ApplicationController
  before_action :authenticate_user!
  before_filter :todo_params, only: [:create, :update]

  def create
    @todo = Todo.create(params[:todo])
    assign_project_to_user

    respond_to do |format|
      format.json
    end
  end

  def update
    todo = Todo.find_by_id(todo_params[:id])
    todo.update_attributes!(todo_params)

    render json: todo
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
