users = @users

json.array! users.each do |user|
  json.extract! user, :id, :name, :admin

  json.todos_done user.todos.select{ |todo| todo.status == 'done' }.each do |todo|
    json.extract! todo, :id, :name, :status, :project_id
  end

  json.todos_in_progress user.todos.select{ |todo| todo.status == 'in progress' }.each do |todo|
    json.extract! todo, :id, :name, :status, :project_id
  end

  json.todos_new user.todos.select{ |todo| todo.status == 'new' }.each do |todo|
    json.extract! todo, :id, :name, :status, :project_id
  end
end
