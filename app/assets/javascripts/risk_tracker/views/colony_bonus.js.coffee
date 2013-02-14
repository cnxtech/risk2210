class RiskTracker.Views.ColonyBonus extends Backbone.View

  template: JST['risk_tracker/templates/colony_bonus']

  events:
    "click .btn.btn-success": "endGame"

  render: ()->
    @$el.html(@template({game_players: @model.gamePlayers.models}))
    return @

  activate: ()->
    @$el.modal(backdrop: "static")

  endGame: (event)->
    event.preventDefault()
    data = {game_id: @model.get('id'), colony_influence: {}}

    @$el.find("input[type='number']").each (index, input)=>
      input = $(input)
      game_player = @model.gamePlayers.find(input.data("game-player-id"))
      data.colony_influence[game_player.get('id')] = parseInt(input.val())

    $.ajax
      url:  "/api/v1/end-game",
      type: "PUT",
      data: data,
      error: (xhr, status, error)->
        console.log(error)
      success: ()=>
        window.location = "/games/#{@model.get('id')}/results"



