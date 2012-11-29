#= require application
#= require risk_tracker

describe "RiskTracker.Models.Faction", ()->

  describe "fusionConservancy", ()->
    it "should be The Fusion Conservancy", ()->
      faction = new RiskTracker.Models.Faction(name: "The Fusion Conservancy")
      expect(faction.fusionConservancy()).toBeTruthy()

  describe "megaCorp", ()->
    it "should be MegaCorp", ()->
      faction = new RiskTracker.Models.Faction(name: "MegaCorp")
      expect(faction.megaCorp()).toBeTruthy()

  describe "default", ()->
    it "should be Default", ()->
      faction = new RiskTracker.Models.Faction(name: "Default")
      expect(faction.default()).toBeTruthy()

  describe "iconFileName", ()->
    it "should return the filename of the faction's icon", ()->
      faction = new RiskTracker.Models.Faction(name: "The Fusion Conservancy")
      expect(faction.iconFileName()).toEqual("/assets/faction_icons/the_fusion_conservancy.png")
