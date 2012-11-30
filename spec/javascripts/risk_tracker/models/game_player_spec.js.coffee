#= require application
#= require risk_tracker

describe "RiskTracker.Models.GamePlayer", ()->

  describe "territoryCount", ()->
    it "should return the number of territories a player has", ()->
      game_player = new RiskTracker.Models.GamePlayer(territory_count: 20)

      expect(game_player.territoryCount()).toEqual(20)

  describe "energy", ()->
    describe "faction other than The Fusion Conservancy", ()->
      it "should return the amount of energy the game player is collecting", ()->
        game_player = new RiskTracker.Models.GamePlayer(territory_count: 12)

        expect(game_player.energy()).toEqual(4)

    describe "The Fusion Conservancy", ()->
      it "should return the amount of energy the game player is collecting, rounded up 20%", ()->
        faction = new RiskTracker.Models.Faction(name: "The Fusion Conservancy")
        game_player = new RiskTracker.Models.GamePlayer(territory_count: 12, faction: faction)

        expect(game_player.energy()).toEqual(5)

    describe "with a continental bonus", ()->
      it "should include the bonus energy", ()->
        continent = new RiskTracker.Models.Continent(bonus: 7)
        game_player = new RiskTracker.Models.GamePlayer(territory_count: 12)
        game_player.addContinent(continent)

        expect(game_player.energy()).toEqual(11)

  describe "units", ()->
    describe "faction other than MegaCorp", ()->
      it "should return the amount of units the game player is collecting", ()->
        game_player = new RiskTracker.Models.GamePlayer(territory_count: 12)

        expect(game_player.units()).toEqual(4)

    describe "MegaCorp", ()->
      it "should return the amount of units the game player is collecting, rounded up 20%", ()->
        faction = new RiskTracker.Models.Faction(name: "MegaCorp")
        game_player = new RiskTracker.Models.GamePlayer(territory_count: 12, faction: faction)

        expect(game_player.units()).toEqual(5)

    describe "with a continental bonus", ()->
      it "should include the bonus units", ()->
        continent = new RiskTracker.Models.Continent(bonus: 7)
        game_player = new RiskTracker.Models.GamePlayer(territory_count: 12)
        game_player.addContinent(continent)

        expect(game_player.units()).toEqual(11)

