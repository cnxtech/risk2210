class RiskTracker.Views.GamePlayer extends Backbone.View
  
  template: JST['risk_tracker/templates/game_player']

  events:
    "click .increment-territory-count": "incrementTerritoryCount"
    "click .decrement-territory-count": "decrementTerritoryCount"
    "click .save-turn": "saveTurn"

  initialize: ()->
    _.bindAll(@, 'render')
    @model.bind("reset", @render)
    @model.bind("change:energy", @_updateEnergyDisplay)
    @model.bind("change:energy", @_updateBorderGlow)
    @model.bind("change:units", @_updateUnitsDisplay)
    @model.bind("change:territory_count", @_updateTerritoryDisplay)
    _.defer(@_updateBorderGlow)
    
  render: ()->
    $(@el).html(@template({game_player: @model}))
    @_bindDropZones()
    @

  incrementTerritoryCount: (event)->
    event.preventDefault()
    @model.incrementTerritoryCount()
  
  decrementTerritoryCount: (event)->
    event.preventDefault()
    @model.decrementTerritoryCount()

  saveTurn: (event)->
    event.preventDefault()
    @model.saveTurn()

  _updateTerritoryDisplay: ()=>
    @_spinCounter(".territory-counter", @model.territoryCount())
    
  _updateUnitsDisplay: ()=>
    @_spinCounter(".unit-counter", @model.units())

  _updateEnergyDisplay: ()=>
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

  _updateBorderGlow: ()=>
    $(@el).animate({boxShadow: "0 0 #{@model.borderGlow()}px"})

  ## FIXME - Don't remove points if dropping to current view
  _bindDropZones: ()->
    $(@el).find(".continent-list").bind "sortreceive", (event, ui) =>
      continent_id = ui.item.attr('data-id')
      continent = window.Game.maps.findContinentById(continent_id)
      @model.addContinent(continent)

    $(@el).find(".continent-list").bind "sortremove", (event, ui) =>
      continent_id = ui.item.attr('data-id')
      continent = window.Game.maps.findContinentById(continent_id)
      @model.removeContinent(continent)
