class RiskTracker.Collections.Continents extends Backbone.Collection
  model: RiskTracker.Models.Continent

  land: ()->
    @where(type: "Land")

  water: ()->
    _([@where(type: "Water"), @where(type: "Lava")]).flatten()

  lunar: ()->
    @where(type: "Lunar")