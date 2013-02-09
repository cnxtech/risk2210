class RiskTracker.Views.GamePlayer extends Backbone.View

  template: JST['risk_tracker/templates/game_player']

  mode: "info"

  events:
    "click .increment-territory-count": "incrementTerritoryCount"
    "click .decrement-territory-count": "decrementTerritoryCount"
    "click .save-turn":                 "endTurn"
    "click .invade":                    "invadeTerritories"
    "click .territories":               "showContinentModal"
    "click .end-invasion":              "endInvasion"
    "click .invade-player":             "invadePlayerOccupied"
    "click .invade-empty":              "invadeEmpty"

  initialize: ()->
    @game = @options.game
    @gameView = @options.gameView
    @util = new RiskTracker.Util()

    @model.bind("change:energy", @_updateEnergyDisplay)
    @model.bind("change:energy", @_updateBorderGlow)
    @model.bind("change:units", @_updateUnitsDisplay)
    @model.bind("change:territory_count", @_updateTerritoryDisplay)
    @model.bind("change:turn_order", @render)
    @model.continents.bind("add", @render)
    @model.continents.bind("remove", @render)
    _.defer(@_updateBorderGlow)

  render: ()=>
    @$el.html(@template({game_player: @model, mode: @mode}))
    @gameView.activatePlayer(@model) if @game.currentPlayer == @model
    @$el.find(".faction-logo").popover(title: @model.faction.get('name'), content: @model.faction.get('abilities'))
    @showInfoCard() if @mode is 'info'
    @showInvadeCard() if @mode is 'invade'
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
    @game.endTurn()
    @gameView.activateNextPlayer()

  invadeTerritories: (event)->
    event.preventDefault()
    @showInvadeCard()

  _updateTerritoryDisplay: ()=>
    @_spinCounter(".territory-counter", @model.territoryCount())

  _updateUnitsDisplay: ()=>
    @_spinCounter(".unit-counter", @model.units())

  _updateEnergyDisplay: ()=>
    @_spinCounter(".energy-counter", @model.energy())

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

  showTurnControls: ()->
    saveTurnContainer = @$el.find(".save-turn-container")
    saveTurnContainer.show() unless saveTurnContainer.is(":visible")

  hideTurnControls: ()->
    saveTurnContainer = @$el.find(".save-turn-container")
    saveTurnContainer.hide() unless saveTurnContainer.is(":hidden")

  showContinentModal: (event)->
    continentType = $(event.target).data("continentType")
    if continentType is undefined
      continentType = $(event.target).parents(".territories").data("continentType")

    @gameView.showContinents(@model, continentType)

  endInvasion: (event)->
    event.preventDefault()
    @showInfoCard()

  invadePlayerOccupied: (event)->
    event.preventDefault()
    defender = @model.game.gamePlayers.find($(event.target).data("game-player-id"))
    defender.decrementTerritoryCount()
    @model.incrementTerritoryCount()
    @render()

  invadeEmpty: (event)->
    event.preventDefault()
    @model.incrementTerritoryCount()
    @render()

  showInfoCard: ()->
    @mode = "info"
    @$el.find(".info-card").show()
    @$el.find(".invade-card").hide()

  showInvadeCard: ()->
    @mode = "invade"
    @$el.find(".info-card").hide()
    @$el.find(".invade-card").show()
