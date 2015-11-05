# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

UsersTodo.destroy_all
Todo.destroy_all
Project.destroy_all
User.destroy_all

# Seed for creating users and give admin rights to `Hari`
['Hari', 'Arnab', 'Abhishek', 'Rana', 'Jalendra'].each{ |name| User.create!({name: name, email: "#{name.downcase}@promobitech.com", password: "test1234", password_confirmation: "test1234", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-02-06 14:02:10", last_sign_in_at: "2015-02-06 14:02:10", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1"}) }
User.find_by_email('hari@promobitech.com').update_attributes({admin: true})

# Seed for creating projects
['Aurora', 'Bigfish', 'Bongo', 'Casanova', 'Cascade', 'GQS', 'Velocity', 'Ziggy'].each { |name| Project.create!({name: name}) }

# Seed for creating todos
project_ids = Project.all.map(&:id)
status = ['new', 'in progress', 'done']
(1..(rand(20..40))).each do |num|
  todo = Todo.create!({name: "Task #{num}", status: status.sample, project_id: project_ids.sample})
  user = User.where.not('admin = true').sample
  user.todos << todo
  user.projects << todo.project unless user.projects.include?(todo.project)
  user.save!
end