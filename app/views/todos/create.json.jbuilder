todo = @todo

json.extract! todo, :id, :name, :status, :project_id
json.user_name todo.users_todo.user.name
json.user_id todo.users_todo.user.id
