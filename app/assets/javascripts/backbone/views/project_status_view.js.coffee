ProjectManagement.Views ||= {}

class ProjectManagement.Views.ProjectStatusView extends Backbone.View

  el: '#project-management-detail-view'

  template: JST["backbone/templates/project_status"]

  initialize: (options) ->
    @options = options || {}

  render: ->
    @user = @options.user
    @$el.html(@template())
    if @user.get('admin') then @generateDynamicTable('admin') else @generateDynamicTable('developer')

  fetchDevelopers: ->
    @developers = new ProjectManagement.Collections.UsersCollection()
    @developers.fetch({ async:false })

  generateDynamicTable: (role) ->
    @fetchDevelopers() if _.isEqual(role, 'admin')
    collection = if _.isEqual(role, 'admin') then @developers else @user.get('projects')
    @createHeader(collection)
    for status in ['done', 'in-progress', 'new']
      @createTable(".status-#{status}-table", "#{status}", @getMaxRowLength(status, collection), collection.length)
      @feedDataWithinTable(status, collection)

  createTable: (table_selector, status, rows, cols) ->
    my_table = $(table_selector)
    row = 0
    while row++ < rows
      row_html  = $('<tr></tr>').attr(class: "#{status}-sataus-row-#{row}").appendTo(my_table)
      col = 0
      while col++ < cols
        $('<td></td>').attr(class: "#{status}-sataus-row-#{row}-col-#{col}").appendTo row_html

  feedDataWithinTable: (status, collection) ->
    row = 0
    while row++ < @getMaxRowLength(status, collection)
      col = 0
      while col++ < collection.length
        $(".#{status}-sataus-row-#{row}-col-#{col}").text(collection.models[col-1].get(@todo_status(status))[row-1].name) if collection.models[col-1].get(@todo_status(status))[row-1] != undefined

  getMaxRowLength: (status, collection) ->
    array_length = []
    array_length.push model.get(@todo_status(status)).length for model in collection.models
    _.max(array_length)

  createHeader: (collection) ->
    @createTable('.status-header-table', 'header', 1, collection.length)
    $(".header-sataus-row-#{1}-col-#{++col || col = 1}").text(model.get('name')) for model in collection.models

  todo_status: (status) -> "todos_#{status.replace('-', '_')}"