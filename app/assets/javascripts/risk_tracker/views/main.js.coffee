class RiskTracker.Views.Main extends Backbone.View

  #template: JST['risk_tracker/templates/games/index']
  #id: "game-players"


  initialize: ()->
    _.bindAll(@, 'render')
    @collection.bind("reset", @render)
    #@collection.on('reset', @render, this)

  render: ()->
    @collection.each (game_player) =>
      view = new RiskTracker.Views.GamePlayer(model: game_player)
      $(@el).append(view.render().el)
    @
