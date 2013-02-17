class RiskTracker.Models.Faction extends Backbone.Model

  fusionConservancy: ()->
    @get("name") is "The Fusion Conservancy"

  megaCorp: ()->
    @get("name") is "MegaCorp"

  freeMilitia: ()->
    @get("name") is "Free Militia"

  preservation: ()->
    @get("name") is "Preservation"

  default: ()->
    @get("name") == "Default"

  iconFileName: ()->
    util = new RiskTracker.Util()
    util.factionIconFileName(@get('name'))
