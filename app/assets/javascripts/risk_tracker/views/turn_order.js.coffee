class RiskTracker.Views.TurnOrder extends Backbone.View

  template: JST['risk_tracker/templates/turn_order']

  events:
    "click .btn.btn-success": "saveTurnOrder"

  initialize: ()->
    @gameView = @options.gameView

  render: ()->
    @$el.html(@template({game_players: @collection.models}))
    return @

  saveTurnOrder: (event)->
    event.preventDefault()
    @setTurnOrder()
    if @validate()
      next_player = @collection.where(turn_order: 1)[0]
      @gameView.model.startYear()
      @gameView.activatePlayer(next_player)
      @$el.modal('hide')
    else
      alert("All players must have a unique turn order.")

  setTurnOrder: ()->
    @$el.find("input[type='number']").each (index, input)=>
      input = $(input)
      game_player = @collection.find(input.data("game-player-id"))
      game_player.set({turn_order: parseInt(input.val())})

  validate: ()->
    turns = []
    _(@collection.models).each (game_player, index)=>
      turns.push(game_player.turnOrder())

    return false if _.uniq(turns).length < @collection.models.length
    return true
