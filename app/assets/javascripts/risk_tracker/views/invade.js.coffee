class RiskTracker.Views.Invade extends Backbone.View

  template: JST['risk_tracker/templates/invade']

  className: "invade-card"

  events:
    "click .end-invasion": "endInvasion"
    "click .invade"      : "invade"
    "click .invade-empty": "invadeEmpty"

  initialize: ()->
    console.log "invade init"

  render: ()->
    @$el.html(@template({model: @model}))
    return @

  endInvasion: (event)->
    event.preventDefault()

    @$el.siblings().show()
    @$el.hide()

  invade: (event)->
    event.preventDefault()
    defender = @model.game.gamePlayers.find($(event.target).data("game-player-id"))
    defender.decrementTerritoryCount()
    @model.incrementTerritoryCount()

  invadeEmpty: (event)->
    event.preventDefault()
    @model.incrementTerritoryCount()
