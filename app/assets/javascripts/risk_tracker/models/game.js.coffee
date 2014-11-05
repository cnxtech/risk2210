class RiskTracker.Models.Game extends Backbone.Model

  currentPlayer: null
  availableContinents: null

  initialize: ()->
    @gamePlayers = new RiskTracker.Collections.GamePlayers(@get("game_players"))
    @gamePlayers.game = @
    @turns = new RiskTracker.Collections.Turns(@get("turns"))
    @gamePlayers.each (gamePlayer)=>
      gamePlayer.game = @
      @currentPlayer = gamePlayer if gamePlayer.get("id") is @get("current_player_id")

    @maps = new RiskTracker.Collections.Maps(@get("maps"))
    @_initializeAvailableContinents()

  turnCount: ()->
    @turns.models.length

  currentPlayer: ()->
    @currentPlayer

  setCurrentPlayer: (current_player)->
    @currentPlayer = current_player

  endTurn: ()->
    gamePlayerStats = []

    _(@gamePlayers.models).each (gamePlayer)->
      gamePlayerStats.push {
        game_player_id:  gamePlayer.get("id")
        units:           gamePlayer.units(),
        energy:          gamePlayer.energy(),
        territory_count: gamePlayer.territoryCount(),
        continent_ids:   gamePlayer.continentIds(),
        space_stations:  gamePlayer.spaceStations()
      }

    @turns.create(game_id: @get("id"), game_player_id: @currentPlayer.get("id"), order: @currentPlayer.turnOrder(), year: @get('current_year'), game_player_stats_attributes: gamePlayerStats)

  startYear: ()->
    newYear = @get("current_year") + 1
    @set({current_year: newYear})

    $.ajax
      url:  "/api/v1/games/#{@get('id')}/start_year",
      type: "PUT",
      data: @gamePlayers.toTurnOrder(),
      error: (xhr, status, error)->
        console.log(error)

  updateTurnOrder: ()->
    $.ajax
      url:  "/api/v1/games/#{@get('id')}/update_turn_order",
      type: "PUT",
      data: @gamePlayers.toTurnOrder(),
      error: (xhr, status, error)->
        console.log(error)

  lastYear: ()->
    @get("current_year") is @get("number_of_years")

  _initializeAvailableContinents: () ->
    @availableContinents = new RiskTracker.Collections.Continents(@maps.continents())

    @gamePlayers.each (gamePlayer) ->
      gamePlayer.setStartingContinents()
