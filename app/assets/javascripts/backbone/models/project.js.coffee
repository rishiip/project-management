class ProjectManagement.Models.Project extends Backbone.RelationalModel
  urlRoot: '/projects'

  relations: [
    {
      type: Backbone.HasMany,
      key: 'todos',
      relatedModel: 'ProjectManagement.Models.Todo',
      collectionType: 'ProjectManagement.Collections.TodosCollection'
      reverseRelation:
        key: 'project'
        includeInJSON: 'project_id'
    },
    {
      type: Backbone.HasMany,
      key: 'users',
      relatedModel: 'ProjectManagement.Models.User',
      collectionType: 'ProjectManagement.Collections.UsersCollection'
    }
  ]

class ProjectManagement.Collections.ProjectsCollection extends Backbone.Collection
  model: ProjectManagement.Models.Project
  url: '/projects'