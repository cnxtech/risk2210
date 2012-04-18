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
    $(@el).html(@template({game_player: @model, skin_number: @attributes.skin_number}))
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
    @_updateCounter(".territory-counter", @model.territoryCount())
    @_updateCounter(".unit-counter", @model.units())
    @_updateCounter(".energy-counter", @model.energy())

  _updateCounter: (selector, end)->
    element = $(@el).find(selector)
    start = parseInt(element.html())
    return if start is end
    
    current = start
    i = setInterval(->
      if current is end
        clearInterval i
        element.animate {}
      else
        if start > end
          current--
        else
          current++
        element.html(current).animate {}, 100
    , 100)
