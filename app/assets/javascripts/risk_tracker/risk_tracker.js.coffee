window.RiskTracker =
  Models: {}
  Collections: {}
  Views: {}
  #Routers: {}
  init: ()->
    view = new RiskTracker.Views.Main(collection: window.GamePlayers)
    $('#game-players').html(view.render().el)
  #  new RiskTracker.Routers.Game()
  #  Backbone.history.start()

$(document).ready ->
  RiskTracker.init()