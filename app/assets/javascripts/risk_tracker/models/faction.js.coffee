class RiskTracker.Models.Faction extends Backbone.Model

  fusionConservancy: ()->
    @get("name") == "The Fusion Conservancy"

  megaCorp: ()->
    @get("name") == "MegaCorp"

  minEnergy: ()->
    return 4 if @fusionConservancy()
    return 3

  minUnits: ()->
    return 4 if @megaCorp()
    return 3

  iconFileName: ()->
    @get('name').toLowerCase().split(" ").join("_")