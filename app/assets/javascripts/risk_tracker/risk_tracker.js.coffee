window.RiskTracker =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new RiskTracker.Routers.Games()
    Backbone.history.start()

$(document).ready ->
  RiskTracker.init()