class RiskTracker.Models.Map extends Backbone.Model

  initialize: ()->
    @continents = new RiskTracker.Collections.Continents(@get("continents"))
