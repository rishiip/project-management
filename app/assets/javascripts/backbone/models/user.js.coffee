class ProjectManagement.Models.User extends Backbone.Model
  urlRoot: '/users'

class ProjectManagement.Collections.UsersCollection extends Backbone.Collection
  model: ProjectManagement.Models.User
  url: '/users'