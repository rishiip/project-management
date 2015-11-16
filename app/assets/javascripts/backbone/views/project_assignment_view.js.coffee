ProjectManagement.Views ||= {}

class ProjectManagement.Views.ProjectAssignmentView extends Backbone.View

  el: '#project-management-detail-view'

  template: JST["backbone/templates/project_assignment"]

  events: {
    'keyup .new-project': 'enableCreateButton'
    'click .btn-new-project': 'createProject'
  }

  initialize: (options) ->
    @options = options || {}

  render: ->
    @fetchUser()
    if @user.get('admin')
      @fetchProjects()
      @fetchDevelopers()
    @$el.html(@template(admin: @user.get('admin')))
    @appendProjects()

  createProject: ->
    project = new ProjectManagement.Models.Project()
    project.save(name: @$('.new-project').val(),
      success: (model, response) =>
        @projects.add(model)
        @appendSingleProject(model)
    )
    @$('.new-project').val('')

  appendProjects: ->
    @projects = if @user.get('admin') then @projects.models else @user.get('projects').models
    @appendSingleProject(project) for project in @projects

  appendSingleProject: (project) ->
    project_row_view = new ProjectManagement.Views.ProjectRowView({ project: project, developers: @developers })
    @$('.project-list-view').append(project_row_view.render().el)

  enableCreateButton: (e) ->
    attr_value = if _.isEqual(e.target.value, '') then true else false
    $(".btn-new-project").attr('disabled', attr_value)

  fetchProjects: ->
    @projects = new ProjectManagement.Collections.ProjectsCollection()
    @projects.fetch({ async:false })

  fetchDevelopers: ->
    @developers = new ProjectManagement.Collections.UsersCollection()
    @developers.fetch({ async:false })

  fetchUser: ->
    @user = ProjectManagement.Models.User.find({id: parseInt($('#user_id').val())})
    return unless _.isEqual(@user, null)
    @user = new ProjectManagement.Models.User({id: parseInt($('#user_id').val())})
    @user.fetch({ async:false })
