users = @users

json.users users.each do |user|
  json.merge! user.attributes

  json.projects user.projects.each do |project|
    json.merge! project.attributes
    json.todos project.todos.each do |todo|
      json.merge! todo.attributes
    end
  end

  json.todos do
    json.merge! user.todos
  end

  json.todos_done do
    json.merge! user.todos.select{ |todo| todo.status == 'done' }
  end

  json.todos_in_progress do
    json.merge! user.todos.select{ |todo| todo.status == 'in progress' }
  end

  json.todos_new do
    json.merge! user.todos.select{ |todo| todo.status == 'new' }
  end
end
