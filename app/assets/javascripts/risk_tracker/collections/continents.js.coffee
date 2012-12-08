class RiskTracker.Collections.Continents extends Backbone.Collection
  model: RiskTracker.Models.Continent

  land: ()->
    @where(type: "Land")

  water: ()->
    @where(type: "Water")

  lunar: ()->
    @where(type: "Lunar")
