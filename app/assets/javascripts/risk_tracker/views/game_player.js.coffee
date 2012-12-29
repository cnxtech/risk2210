class RiskTracker.Views.GamePlayer extends Backbone.View

  template: JST['risk_tracker/templates/game_player']

  events:
    "click .increment-territory-count": "incrementTerritoryCount"
    "click .decrement-territory-count": "decrementTerritoryCount"
    "click .save-turn": "saveTurn"

  initialize: (options={})->
    @game = options.attributes.game
    @util = new RiskTracker.Util()

    @model.bind("change:energy", @_updateEnergyDisplay)
    @model.bind("change:energy", @_updateBorderGlow)
    @model.bind("change:units", @_updateUnitsDisplay)
    @model.turns.bind("add", @_updateTurnsDisplay)
    @model.bind("change:territory_count", @_updateTerritoryDisplay)
    _.defer(@_updateBorderGlow)

  render: ()->
    @$el.html(@template({game_player: @model}))
    @_bindDropZones()
    return @

  incrementTerritoryCount: (event)->
    event.preventDefault()
    @_beep()
    @model.incrementTerritoryCount()

  decrementTerritoryCount: (event)->
    event.preventDefault()
    @_beep()
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

  _updateTurnsDisplay: ()=>
    @$el.find(".turn-counter").html(@model.turn())

  _spinCounter: (selector, end)->
    element = @$el.find(selector)
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
    @$el.animate({boxShadow: "0 0 #{@model.borderGlow()}px"})

  _bindDropZones: ()->
    @$el.find(".continent-list").bind "sortreceive", (event, ui) =>
      continent_id = ui.item.data('id')
      continent = @game.maps.findContinentById(continent_id)
      @model.addContinent(continent)

    @$el.find(".continent-list").bind "sortremove", (event, ui) =>
      continent_id = ui.item.data('id')
      continent = @game.maps.findContinentById(continent_id)
      @model.removeContinent(continent)

  _beep: ()->
    sound = new Audio()
    sound.src = @util.beepPath()
    sound.play()
