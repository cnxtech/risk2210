class RiskTracker.Models.Faction extends Backbone.Model

  fusionConservancy: ()->
    @get("name") == "The Fusion Conservancy"

  megaCorp: ()->
    @get("name") == "MegaCorp"

  default: ()->
    @get("name") == "Default"

  iconFileName: ()->
    util = new RiskTracker.Util()
    util.factionIconFileName(@get('name'))