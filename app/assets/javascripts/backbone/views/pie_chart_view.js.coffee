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
    @project_collection = new ProjectManagement.Collections.ProjectsCollection()
    @project_collection.fetch({ async:false })
    @projects = _.first(@project_collection.models).get('projects')

  generateChart: ->
    @$el.html('')
    @$el.append(@createChart(project).render().el).append('<hr>') for project in @projects

  createChart: (project) ->
    new Backbone.GoogleChart({
      chartType: 'PieChart',
      dataTable: [['type', 'String'], ['done', project.todos_done_count], ['in progress', project.todos_in_progress_count], ['new', project.todos_new_count]],
      options: {'title': project.name}
    })