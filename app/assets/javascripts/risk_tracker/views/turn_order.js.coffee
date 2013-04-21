class RiskTracker.Views.TurnOrder extends Backbone.View

  template: JST['risk_tracker/templates/turn_order']

  mode: "end_year"

  events:
    "click .btn.btn-success": "saveTurnOrder"

  initialize: ()->
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
        @gameView.trigger("start_new_year")
      else
        @gameView.updateTurnOrder()

      @$el.modal('hide')
    else
      alert("All players must have a unique turn order.")

  _setTurnOrder: ()->
    @_turnOrderFields().each (index, input)=>
      input = $(input)
      game_player = @collection.find(input.data("game-player-id"))
      game_player.set({turn_order: parseInt(input.val())})

  _validate: ()->
    turns = []
    _(@collection.models).each (game_player, index)=>
      turns.push(game_player.turnOrder())

    return false if _.compact(_.uniq(turns)).length < @collection.models.length
    return true

  _turnOrderFields: ()->
    @$el.find("input[type='number']")
