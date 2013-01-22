class RiskTracker.Models.Game extends Backbone.Model

  currentPlayer: null
  availableContinents: null

  initialize: ()->
    @gamePlayers = new RiskTracker.Collections.GamePlayers(@get("game_players"))
    @turns = new RiskTracker.Collections.Turns(@get("turns"))
    @gamePlayers.each (gamePlayer)=>
      gamePlayer.game = @
      @currentPlayer = gamePlayer if gamePlayer.get("turn_order") is 1

    @maps = new RiskTracker.Collections.Maps(@get("maps"))

  turnCount: ()->
    @turns.models.length

  currentPlayer: ()->
    @currentPlayer

  endTurn: ()->
    game_player_stats = []

    _(@gamePlayers.models).each (game_player)->
      game_player_stats.push {
        game_player_id:  game_player.get("id")
        units:           game_player.units(),
        energy:          game_player.energy(),
        territory_count: game_player.territoryCount(),
        continent_ids:   game_player.continentIds()
      }

    @turns.create(game_id: @get("id"), game_player_id: @currentPlayer.get("id"), order: @currentPlayer.turnOrder(), game_player_stats_attributes: game_player_stats)
