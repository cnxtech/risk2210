class RiskTracker.Views.GamePlayer extends Backbone.View

  template: JST['risk_tracker/templates/game_player']

  invadeView: null

  events:
    "click .increment-territory-count": "incrementTerritoryCount"
    "click .decrement-territory-count": "decrementTerritoryCount"
    "click .save-turn":                 "endTurn"
    "click .invade":                    "invadeTerritories"
    "click .territories":               "showContinentModal"

  initialize: ()->
    @game = @options.game
    @util = new RiskTracker.Util()
    @invadeView = new RiskTracker.Views.Invade(model: @model)

    @model.bind("change:energy", @_updateEnergyDisplay)
    @model.bind("change:energy", @_updateBorderGlow)
    @model.bind("change:units", @_updateUnitsDisplay)
    @model.turns.bind("add", @_updateTurnsDisplay)
    @model.bind("change:territory_count", @_updateTerritoryDisplay)
    @model.continents.bind("add", @render)
    @model.continents.bind("remove", @render)
    _.defer(@_updateBorderGlow)

  render: ()=>
    @$el.html(@template({game_player: @model}))
    @$el.find(".invade-card").append(@invadeView.render().el)
    return @

  incrementTerritoryCount: (event)->
    event.preventDefault()
    @_beep()
    @model.incrementTerritoryCount()

  decrementTerritoryCount: (event)->
    event.preventDefault()
    @_beep()
    @model.decrementTerritoryCount()

  endTurn: (event)->
    event.preventDefault()
    @model.endTurn()

  invadeTerritories: (event)->
    event.preventDefault()
    @$el.find(".info-card").hide()
    @$el.find(".invade-card").show()

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

  _beep: ()->
    sound = new Audio()
    sound.src = @util.beepPath()
    sound.play()

  showContinentModal: (event)->
    @game.currentPlayer = @model
    continentType = $(event.target).data("continentType")
    if continentType is undefined
      continentType = $(event.target).parents(".territories").data("continentType")

    container = $("##{continentType}-continents")
    container.find(".player-name").text(@model.get("handle"))

    container.find(".claimed span.continent").each (index, span)=>
      label = $(span)
      continentId = label.data("id")
      if !@model.hasContinent(continentId)
        label.hide()
      else
        label.show() if label.is(":hidden")

    container.find(".unclaimed span.continent").each (index, span)=>
      label = $(span)
      continentId = label.data("id")
      if @model.hasContinent(continentId) or !@game.availableContinents.hasContinent(continentId)
        label.hide()
      else
        label.show() if label.is(":hidden")

    container.modal()
