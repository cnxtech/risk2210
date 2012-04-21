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
    
  render: ()->
    $(@el).html(@template({game_player: @model, skin_number: @attributes.skin_number}))
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
    console.log "Turn saved!"
    ## Keep track of turns
    ## Update Progress Bar

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
    border = @model.energy() * 5
    $(@el).find(".player-card").animate({boxShadow: "0 0 #{border}px"})

  _bindDropZones: ()->
    $(@el).find(".continent-list").bind "sortreceive", (event, ui) =>
      continent_id = ui.item.attr('data-id')
      continent = window.Maps.findContinentById(continent_id)
      @model.addContinent(continent)

    $(@el).find(".continent-list").bind "sortremove", (event, ui) =>
      continent_id = ui.item.attr('data-id')
      continent = window.Maps.findContinentById(continent_id)
      @model.removeContinent(continent)
      
