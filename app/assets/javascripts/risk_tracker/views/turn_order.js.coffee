class RiskTracker.Views.TurnOrder extends Backbone.View

  template: JST['risk_tracker/templates/turn_order']

  mode: "end_year"

  events:
    "click .btn.btn-success": "saveTurnOrder"

  initialize: (@options={})->
    @gameView = @options.gameView

  render: ()->
    @$el.html(@template({game_players: @collection.models}))
    return @

  activate: (mode='end_year')->
    @mode = mode
    @_turnOrderFields().each (index, field) -> $(field).val("")

    year = @gameView.model.get("current_year")
    if mode is 'end_year'
      year += 1

    @$el.find(".year").text(year)
    @$el.modal(backdrop: "static")

  saveTurnOrder: (event)->
    event.preventDefault()
    @_setTurnOrder()
    if @_validate()
      if @mode is "end_year"
        @gameView.trigger("start-new-year")
      else
        @gameView.updateTurnOrder()

      @$el.modal('hide')
    else
      alert("All players must have a unique turn order less or equal to the number of players.")

  _setTurnOrder: ()->
    @_turnOrderFields().each (index, input)=>
      input = $(input)
      gamePlayer = @collection.find(input.data("game-player-id"))
      gamePlayer.set({turn_order: parseInt(input.val())})

  _validate: ()->
    turns = []
    _(@collection.models).each (gamePlayer, index)=>
      turns.push(gamePlayer.turnOrder())

    return false if _.compact(_.uniq(turns)).length < @collection.models.length
    return false if _.max(_.compact(_.uniq(turns))) > @collection.models.length
    return true

  _turnOrderFields: ()->
    @$el.find("input[type='number']")
