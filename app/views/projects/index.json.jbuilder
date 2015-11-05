projects = @projects

json.projects projects.each do |project|
  json.extract! project, :id, :name

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

