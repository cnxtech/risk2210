class RiskTracker.Views.GamePlayer extends Backbone.View
  
  template: JST['risk_tracker/templates/game_player']

  events:
    "click .increment-territory-count": "incrementTerritoryCount"
    "click .decrement-territory-count": "decrementTerritoryCount"
    "click .save-turn": "saveTurn"

  initialize: ()->
    _.bindAll(@, 'render')
    @model.bind("reset", @render)

  render: ()->
    $(@el).html(@template({game_player: @model, skin_number: @attributes.skin_number}))
    @

  incrementTerritoryCount: (event)->
    event.preventDefault()
    @model.incrementTerritoryCount()
    @_updateCounters()
  
  decrementTerritoryCount: (event)->
    event.preventDefault()
    @model.decrementTerritoryCount()
    @_updateCounters()

  saveTurn: (event)->
    event.preventDefault()
    alert("Saved!")

  _updateCounters: ()->
    @_spinCounter(".territory-counter", @model.territoryCount())
    @_spinCounter(".unit-counter", @model.units())
    @_spinCounter(".energy-counter", @model.energy())

  _spinCounter: (selector, end)->
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
