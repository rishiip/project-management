ProjectManagement.Views ||= {}

class ProjectManagement.Views.TodoSectionView extends Backbone.View

  el: '.todo-view'

  template: JST["backbone/templates/todo_section"]

  events: {
    'keyup .new-todo': 'enableCreateButton'
    'change .developer-select': 'enableCreateButton'
  }

  initialize: (options) ->
    @options = options || {}
    @project =  @options.project
    @developers = @options.developers

  render: ->
    @$el.html(@template({ project: @project, unassigned_devs: @unassigned_devs }))
    if @developers
      @initUnassignedDevelopers()
      @appendDevelopers()
      @bindCreateTodo()
      @bindAssignDevToProject()
    else
      @$('.todo-developers-view').hide()
      @$('.todo-create-view').hide()
      @$('.todo-developers-select-view').hide()
    @appendTodos()

  appendDevelopers: ->
    @$('.developer-names').append(developer.get('name') + "&nbsp;&nbsp;") for developer in @project.get('users').models

  appendTodos: ->
    @appendSingleTodo(todo) for todo in @project.get('todos').models

  enableCreateButton: ->
    attr_value = if _.isEqual(@$('.developer-select').val(), '0') or _.isEqual(@$('.new-todo').val(), '') then true else false
    $(".btn-new-todo").attr('disabled', attr_value)

  bindCreateTodo: -> @$('.btn-new-todo').bind 'click', => @createTodo()

  createTodo: ->
    todo = new ProjectManagement.Models.Todo()
    todo.save(user_id: parseInt(@$('select.developer-select').val()), name: @$('input.new-todo').val(), project_id: @project.id, status: 'new',
      success: (model, response) =>
        @project.get('todos').add(model)
        @appendSingleTodo(model)
    )
    @$('select.developer-select').val(0)
    @$('input.new-todo').val('')
    $(".btn-new-todo").attr('disabled', true)

  initUnassignedDevelopers: ->
    project_developers = @project.get('users').models
    @unassigned_devs = _.filter @developers.models, (developer) -> !_.findWhere(project_developers, developer)

  appendSingleTodo: (todo) ->
    todo_row_view = new ProjectManagement.Views.TodoRowView({ todo: todo })
    @$('.todo-list-view').append(todo_row_view.render().el)

  bindAssignDevToProject: ->
    @$('.unassigned-developer-select').bind 'change', => @enableAddDeveloper()
    @$('.btn-add-developer').bind 'click', => @addDevToProject()

  enableAddDeveloper: ->
    attr_value = if _.isEqual(@$('.unassigned-developer-select').val(), '0') then true else false
    @$(".btn-add-developer").attr('disabled', attr_value)

  addDevToProject: ->
    user_id = parseInt(@$('.unassigned-developer-select').val())
    user_name = @$('.unassigned-developer-select option:selected').text()
    @project.url = "projects/#{@project.id}/assign_project/#{user_id}"
    @project.fetch({ async: false })
    @$('select.developer-select').append("<option value='" + user_id + "'>" + user_name + "</option>")
    @$(".unassigned-developer-select option[value='" + user_id + "']").remove()
    @$(".unassigned-developer-select").val(0)
    @$('.developer-names').append("#{user_name}&nbsp;&nbsp;")
    @enableAddDeveloper()
