class RiskTracker.Models.Game extends Backbone.Model

  initialize: ()->
    @gamePlayers = new RiskTracker.Collections.GamePlayers(@get("game_players"))
    @gamePlayers.each (gamePlayer)=>
      gamePlayer.game = @

    @maps = new RiskTracker.Collections.Maps(@get("maps"))

  incrementTurnCount: ()=>
    @set({turn_count: (@get('turn_count') + 1)})
