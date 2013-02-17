class RiskTracker.Models.Game extends Backbone.Model

  currentPlayer: null
  availableContinents: null

  initialize: ()->
    @gamePlayers = new RiskTracker.Collections.GamePlayers(@get("game_players"))
    @gamePlayers.game = @
    @turns = new RiskTracker.Collections.Turns(@get("turns"))
    @gamePlayers.each (gamePlayer)=>
      gamePlayer.game = @
      @currentPlayer = gamePlayer if gamePlayer.get("turn_order") is 1

    @maps = new RiskTracker.Collections.Maps(@get("maps"))

  turnCount: ()->
    @turns.models.length

  currentPlayer: ()->
    @currentPlayer

  setCurrentPlayer: (current_player)->
    @currentPlayer = current_player

  endTurn: ()->
    game_player_stats = []

    _(@gamePlayers.models).each (game_player)->
      game_player_stats.push {
        game_player_id:  game_player.get("id")
        units:           game_player.units(),
        energy:          game_player.energy(),
        territory_count: game_player.territoryCount(),
        continent_ids:   game_player.continentIds(),
        space_stations:  game_player.spaceStations()
      }

    @turns.create(game_id: @get("id"), game_player_id: @currentPlayer.get("id"), order: @currentPlayer.turnOrder(), game_player_stats_attributes: game_player_stats)

  startYear: ()->
    newYear = @get("current_year") + 1
    @set({current_year: newYear})

    $.ajax
      url:  "/api/v1/start-year",
      type: "PUT",
      data: @gamePlayers.toTurnOrder(),
      error: (xhr, status, error)->
        console.log(error)

  lastYear: ()->
    @get("current_year") is @get("number_of_years")
