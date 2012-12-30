window.RiskTracker =
  Models: {}
  Collections: {}
  Views: {}

  boot: ()->
    @game = new RiskTracker.Views.Game()
    @game.render()

$ ->
  RiskTracker.boot()
