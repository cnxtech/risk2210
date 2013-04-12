window.RiskTracker =
  Models: {}
  Collections: {}
  Views: {}

  boot: ()->
    @game = new RiskTracker.Views.Game(window.gameData)
    @game.render()

$ ->
  RiskTracker.boot()
