class RiskTracker.Collections.GamePlayers extends Backbone.Collection
  model: RiskTracker.Models.GamePlayer
  game: null

  find: (id)->
    @where(id: id)[0]

  toTurnOrder: ()->
    data = {payload: {}}
    _(@models).each (game_player)->
      data.payload[game_player.get("id")] = game_player.turnOrder()
    return data
