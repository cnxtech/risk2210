class RiskTracker.Views.GamePlayer extends Backbone.View
  
  template: JST['risk_tracker/templates/game_player']
  #id: "game-player-" + model.id

  events:
    "click .increment-territory-count": "incrementTerritoryCount"
    "click .decrement-territory-count": "decrementTerritoryCount"

  initialize: ()->
    _.bindAll(@, 'render')
    @model.bind("reset", @render)
    #@model.bind("change", @render)

  render: ()->
    $(@el).html(@template(game_player: @model))
    @

  incrementTerritoryCount: (event)->
    event.preventDefault()
    @model.incrementTerritoryCount()
    @updateAssetCounts()
  
  decrementTerritoryCount: (event)->
    event.preventDefault()
    @model.decrementTerritoryCount()
    @updateAssetCounts()

  updateAssetCounts: ()->
    $(@el).find(".territory-counter").html(@model.territoryCount())
    $(@el).find(".unit-counter").html(@model.units())
    $(@el).find(".energy-counter").html(@model.energy())

