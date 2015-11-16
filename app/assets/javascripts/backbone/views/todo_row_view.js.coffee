ProjectManagement.Views ||= {}

class ProjectManagement.Views.TodoRowView extends Backbone.View

  className: 'todo-row'

  template: JST["backbone/templates/todo_row"]

  initialize: (options) ->
    @options = options || {}
    @todo =  @options.todo

  render: =>
    @$el.html(@template( todo: @todo ))
    @
