class AddProjectIdToTodo < ActiveRecord::Migration
  def change
    add_column :todos, :project_id, :integer
  end
end
