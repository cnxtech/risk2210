class RiskTracker.Collections.GamePlayers extends Backbone.Collection
  model: RiskTracker.Models.GamePlayer
  game: null

  find: (id)->
    @where(id: id)[0]

  toTurnOrder: ()->
    data = {game_id: @game.get("id"), turn_order: {}}
    _(@models).each (game_player)->
      data.turn_order[game_player.get("id")] = game_player.turnOrder()
    return data
