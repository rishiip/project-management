class Todo < ActiveRecord::Base
  belongs_to :project
  has_one :users_todo
end
