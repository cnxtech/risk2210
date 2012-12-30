class RiskTracker.Collections.Continents extends Backbone.Collection
  model: RiskTracker.Models.Continent

  land: ()->
    @where(type: "Land")

  water: ()->
    @where(type: "Water")

  lunar: ()->
    @where(type: "Lunar")

  hasContinent: (continentId)->
    _.contains(_(@models).pluck("id"), continentId)
