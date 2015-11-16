class ProjectManagement.Models.Todo extends Backbone.RelationalModel
  urlRoot: '/todos'

class ProjectManagement.Collections.TodosCollection extends Backbone.Collection
  model: ProjectManagement.Models.Todo
  url: '/todos'