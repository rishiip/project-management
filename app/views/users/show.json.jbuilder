user = @user

json.extract! user, :id, :name, :admin

json.projects user.projects.each do |project|
  json.extract! project, :id, :name

  json.todos project.todos.each do |todo|
    json.extract! todo, :id, :name, :status, :project_id
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
end

