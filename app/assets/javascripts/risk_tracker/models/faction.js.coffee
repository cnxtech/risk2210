class RiskTracker.Models.Faction extends Backbone.Model

  fusionConservancy: ()->
    @get("name") == "The Fusion Conservancy"

  megaCorp: ()->
    @get("name") == "MegaCorp"

  startingEnergy: ()->
    return 4 if @fusionConservancy()
    return 3

  startingUnits: ()->
    return 4 if @megaCorp()
    return 3
