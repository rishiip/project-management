#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.ProjectManagement =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
    new ProjectManagement.Routers.ProjectManagementRouter()
    Backbone.history.start()

$(document).ready ->
  ProjectManagement.init()
