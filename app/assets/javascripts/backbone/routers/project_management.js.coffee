class ProjectManagement.Routers.ProjectManagementRouter extends Backbone.Router
  initialize: ->
    @project_management_view = new ProjectManagement.Views.ProjectManagementView()
    @project_management_view.render()