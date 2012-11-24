window.RiskTracker =
  Models: {}
  Collections: {}
  Views: {}

  boot: ()->
    view = new RiskTracker.Views.Game()
    view.render()

$ ->
  RiskTracker.boot()
