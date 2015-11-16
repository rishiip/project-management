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

    project_assignment_view = new ProjectManagement.Views.ProjectAssignmentView()
    project_assignment_view.render()


  loadProjectChartView: (e) ->
    e.preventDefault()

    pie_chart_view = new ProjectManagement.Views.PieChartView()
    pie_chart_view.render()
