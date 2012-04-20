window.RiskTracker =
  Models: {}
  Collections: {}
  Views: {}
  init: ()->
    view = new RiskTracker.Views.Main()
    $('#game-players').html(view.render().el)

$(document).ready ->
  RiskTracker.init()