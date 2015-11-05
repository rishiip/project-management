ProjectManagement.Views ||= {}

class ProjectManagement.Views.ProjectStatusView extends Backbone.View

  el: '#project-management-detail-view'

  template: JST["backbone/templates/project_status"]

  initialize: (options) ->
    @options = options || {}

  render: ->
    @fetchUser()
    @$el.html(@template())
    if @user.get('admin') then @generateDynamicTable('admin') else @generateDynamicTable('developer')

  fetchUser: ->
    @user = new ProjectManagement.Models.User({id: parseInt($('#user_id').val())})
    @user.fetch({ async:false })

  fetchDevelopers: ->
    @user_collection = new ProjectManagement.Collections.UsersCollection()
    @user_collection.fetch({ async:false })
    @developers = _.first(@user_collection.models).get('users')

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
        selector = ".#{status}-sataus-row-#{row}-col-#{col}"
        switch status
          when 'done' then $(selector).text(collection[col-1].todos_done[row-1].name) if collection[col-1].todos_done[row-1] != undefined
          when 'in-progress' then $(selector).text(collection[col-1].todos_in_progress[row-1].name) if collection[col-1].todos_in_progress[row-1] != undefined
          when 'new' then $(selector).text(collection[col-1].todos_new[row-1].name) if collection[col-1].todos_new[row-1] != undefined

  getMaxRowLength: (status, collection) ->
    array_length = []
    for model in collection
      switch status
        when 'done' then array_length.push model.todos_done.length
        when 'in-progress' then array_length.push model.todos_in_progress.length
        when 'new' then array_length.push model.todos_new.length
    _.max(array_length)

  createHeader: (collection) ->
    @createTable('.status-header-table', 'header', 1, collection.length)
    col = 0
    while col++ < collection.length
      selector = ".header-sataus-row-#{1}-col-#{col}"
      $(selector).text(collection[col-1].name)
