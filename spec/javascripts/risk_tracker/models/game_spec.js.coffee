#= require application
#= require risk_tracker

describe "RiskTracker.Models.Game", ()->

  describe "initialize", ()->
    it "should set the game on each game player", ()->
      game = new RiskTracker.Models.Game(game_players: [{id: 1}, {id: 2}])

      game.gamePlayers.each (game_player)->
        expect(game_player.game).toEqual(game)

    it "should setup the maps collection", ()->
      game = new RiskTracker.Models.Game(maps: [{id: 1}, {id: 2}])

      expect(game.maps.length).toEqual(2)

  describe "incrementTurnCount", ()->
    it "should increase the turn count by 1", ()->
      game = new RiskTracker.Models.Game(turn_count: 5)

      game.incrementTurnCount()

      expect(game.get("turn_count")).toBe(6)
