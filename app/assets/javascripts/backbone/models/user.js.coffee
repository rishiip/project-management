class ProjectManagement.Models.User extends Backbone.RelationalModel
  urlRoot: '/users'

  relations: [
    {
      type: Backbone.HasMany,
      key: 'projects',
      relatedModel: 'ProjectManagement.Models.Project',
      collectionType: 'ProjectManagement.Collections.ProjectsCollection'
      reverseRelation:
        key: 'user'
        includeInJSON: 'id'
    }
  ]

class ProjectManagement.Collections.UsersCollection extends Backbone.Collection
  model: ProjectManagement.Models.User
  url: '/users'