class RiskTracker.Models.Faction extends Backbone.Model

  fusionConservancy: ()->
    @get("name") == "The Fusion Conservancy"

  megaCorp: ()->
    @get("name") == "MegaCorp"