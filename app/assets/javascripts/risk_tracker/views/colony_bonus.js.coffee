class RiskTracker.Views.ColonyBonus extends Backbone.View

  template: JST['risk_tracker/templates/colony_bonus']

  events:
    "click .btn.btn-success": "endGame"

  render: ()->
    @$el.html(@template({game_players: @collection.models}))
    return @

  activate: ()->
    @$el.modal(backdrop: "static")

  endGame: (event)->
    event.preventDefault()
    console.log("End game!")
    ## Ajax call to save colony bonus, on success window.location = results page
