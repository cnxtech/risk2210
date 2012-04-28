window.RiskTracker =
  Models: {}
  Collections: {}
  Views: {}
  init: ()->
    view = new RiskTracker.Views.Game()
    $('#game').html(view.render().el)

$ ->
  RiskTracker.init()