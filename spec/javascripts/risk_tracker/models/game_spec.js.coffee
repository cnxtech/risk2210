#= require application
#= require risk_tracker
#= require_tree ./../../fixtures

describe "RiskTracker.Models.Game", ()->

  describe "initialize", ()->
    it "should set the game on each game player", ()->
      game = new RiskTracker.Models.Game(game_players: [{id: 1}, {id: 2}])

      game.gamePlayers.each (game_player)->
        expect(game_player.game).toEqual(game)

    it "should setup the maps collection", ()->
      game = new RiskTracker.Models.Game(maps: [{id: 1}, {id: 2}])

      expect(game.maps.length).toEqual(2)

