class RiskTracker.Models.Map extends Backbone.Model

  initialize: ()->
    @continents = new RiskTracker.Collections.Continents(@get("continents"))

  # findContinentById: (continent_id)->
  #   _.find @continents.models, (continent)->
  #     continent.get('id') is continent_id
