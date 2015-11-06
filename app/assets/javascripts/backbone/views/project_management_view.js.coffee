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
    @fetchUser()
    @$el.html(@template())
    @

  fetchUser: ->
    @user = new ProjectManagement.Models.User({id: parseInt($('#user_id').val())})
    @user.fetch({ async:false })

  loadProjectStatusView: (e) ->
    e.preventDefault()

    project_status_view = new ProjectManagement.Views.ProjectStatusView({ user: @user })
    project_status_view.render()

  loadProjectAssignmentView: (e) ->
    e.preventDefault()

    console.log 'assignment'

  loadProjectChartView: (e) ->
    e.preventDefault()

    pie_chart_view = new ProjectManagement.Views.PieChartView()
    pie_chart_view.render()
