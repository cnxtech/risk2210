class RiskTracker.Views.TurnOrder extends Backbone.View

  template: JST['risk_tracker/templates/turn_order']

  events:
    "click .btn.btn-success": "saveTurnOrder"

  render: ()->
    @$el.html(@template({game_players: @collection.models}))
    return @

  saveTurnOrder: (event)->
    event.preventDefault()
    console.log("Save turn order")
    @$el.modal('hide')
