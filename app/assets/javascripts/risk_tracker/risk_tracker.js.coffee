window.RiskTracker =
  Models: {}
  Collections: {}
  Views: {}
  init: ()->
    view = new RiskTracker.Views.Main(collection: window.GamePlayers)
    $('#game-players').html(view.render().el)

$(document).ready ->
  RiskTracker.init()