ProjectManagement.Views ||= {}

class ProjectManagement.Views.TodoRowView extends Backbone.View

  className: 'todo-row'

  template: JST["backbone/templates/todo_row"]

  initialize: (options) ->
    @options = options || {}
    @todo =  @options.todo

  render: =>
    @$el.html(@template( todo: @todo ))
    @bindStatusSelect() if _.isEqual(@todo.get('user_name'), undefined)
    @

  bindStatusSelect: -> @$('.status-select').bind 'change', => @changeStatus()

  changeStatus: ->
    @$(".status-select option[value='0']").remove()
    status = @$(".status-select").val()
    @todo.set('status': status)
    @todo.save({ async: false })
