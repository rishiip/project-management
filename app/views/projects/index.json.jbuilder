projects = @projects

json.array! projects.each do |project|
  json.extract! project, :id, :name

  json.users project.users.each do |user|
    json.extract! user, :id, :name
  end

  json.todos project.todos.each do |todo|
    json.extract! todo, :id, :name, :status, :project_id
    json.user_name todo.users_todo.user.name
    json.user_id todo.users_todo.user.id
  end

  json.todos_done project.todos.select{ |todo| todo.status == 'done' }.each do |todo|
    json.extract! todo, :id, :name, :status, :project_id
  end

  json.todos_in_progress project.todos.select{ |todo| todo.status == 'in progress' }.each do |todo|
    json.extract! todo, :id, :name, :status, :project_id
  end

  json.todos_new project.todos.select{ |todo| todo.status == 'new' }.each do |todo|
    json.extract! todo, :id, :name, :status, :project_id
  end

  json.todos_done_count project.todos.select{ |todo| todo.status == 'done' }.count
  json.todos_in_progress_count project.todos.select{ |todo| todo.status == 'in progress' }.count
  json.todos_new_count project.todos.select{ |todo| todo.status == 'new' }.count
end

