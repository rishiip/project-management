ProjectManagement.Views ||= {}

class ProjectManagement.Views.ProjectManagementView extends Backbone.View

  el: '#project-management-view'

  template: JST["backbone/templates/main_page"]

  events: {
    'click #project-status': 'loadProjectStatusView'
    'click #project-assignment': 'loadProjectAssignmentView'
    'click #project-chart': 'loadProjectChartView'
  }

  initialize: (options) ->
    @options = options || {}

  render: =>
    @$el.html(@template())
    @

  loadProjectStatusView: (e) ->
    e.preventDefault()

    project_status_view = new ProjectManagement.Views.ProjectStatusView()
    project_status_view.render()

  loadProjectAssignmentView: (e) ->
    e.preventDefault()

    console.log 'assignment'

  loadProjectChartView: (e) ->
    e.preventDefault()

    console.log 'chart'
