ProjectManagement.Views ||= {}
Backbone.GoogleChart ||= {}

class ProjectManagement.Views.PieChartView extends Backbone.View

  el: '#project-management-detail-view'

  initialize: (options) ->
    @options = options || {}

  render: ->
    @fetchProjects()
    @generateChart()

  fetchProjects: ->
    @projects = new ProjectManagement.Collections.ProjectsCollection()
    @projects.fetch({ async:false })

  generateChart: ->
    @$el.html('')
    @$el.append(@createChart(project).render().el).append('<hr>') for project in @projects.models

  createChart: (project) ->
    new Backbone.GoogleChart({
      chartType: 'PieChart',
      dataTable: [['type', 'String'], ['New', project.get('todos_new_count')], ['In Progress', project.get('todos_in_progress_count')], ['Done', project.get('todos_done_count')]],
      options: {'title': project.get('name')}
    })