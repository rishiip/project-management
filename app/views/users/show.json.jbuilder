user = @user

json.merge! user.attributes

json.projects user.projects.each do |project|
  json.merge! project.attributes
  json.todos project.todos.each do |todo|
    json.merge! todo.attributes
  end

  json.todos_done do
    json.merge! project.todos.select{ |todo| todo.status == 'done' }
  end

  json.todos_in_progress do
    json.merge! project.todos.select{ |todo| todo.status == 'in progress' }
  end

  json.todos_new do
    json.merge! project.todos.select{ |todo| todo.status == 'new' }
  end
end

