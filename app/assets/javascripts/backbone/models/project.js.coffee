class ProjectManagement.Models.Project extends Backbone.Model
  urlRoot: '/projects'

class ProjectManagement.Collections.ProjectsCollection extends Backbone.Collection
  model: ProjectManagement.Models.Project
  url: '/projects'