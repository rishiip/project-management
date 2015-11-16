ProjectManagement.Views ||= {}

class ProjectManagement.Views.ProjectRowView extends Backbone.View

  className: 'project-row'

  template: JST["backbone/templates/project_row"]

  events: {
    'click .project-name': 'displayTodods'
  }

  initialize: (options) ->
    @options = options || {}
    @project =  @options.project
    @developers = @options.developers

  render: =>
    @$el.html(@template( project: @project ))
    @

  displayTodods: ->
    todo_section_view = new ProjectManagement.Views.TodoSectionView({ project: @project, developers: @developers })
    todo_section_view.render()