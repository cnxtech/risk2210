class RiskTracker.Models.Game extends Backbone.Model

  currentPlayer: null
  availableContinents: null

  initialize: ()->
    @gamePlayers = new RiskTracker.Collections.GamePlayers(@get("game_players"))
    @gamePlayers.each (gamePlayer)=>
      gamePlayer.game = @
      @currentPlayer = gamePlayer if gamePlayer.get("starting_turn_position") is 1

    @maps = new RiskTracker.Collections.Maps(@get("maps"))

  incrementTurnCount: ()=>
    @set({turn_count: (@get('turn_count') + 1)})

  currentPlayer: ()->
    @currentPlayer
