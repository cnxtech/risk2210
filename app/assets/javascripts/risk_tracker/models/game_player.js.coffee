class RiskTracker.Models.GamePlayer extends Backbone.Model

  initialize: ()->
    @player = new RiskTracker.Models.Player(@get("player"))
    @faction = new RiskTracker.Models.Faction(@get("faction"))
    @set({territory_count: 0, energy: @faction.minEnergy(), units: @faction.minUnits()})
    @bind("change:territory_count", @recalculateAssets)

  territoryCount: ()->
    @get("territory_count")

  energy: ()->
    @get("energy")

  units: ()->
    @get("units")

  incrementTerritoryCount: ()->
    @set({territory_count: @territoryCount() + 1})  

  decrementTerritoryCount: ()->
    if @territoryCount() > 0
      @set({territory_count: @territoryCount() - 1})

  recalculateAssets: ()->
    @recalculateEnergy()
    @reacalculateUnits()
      
  recalculateEnergy: ()->
    energy = @_baseAssets()
    if @faction.fusionConservancy()
      energy = energy + Math.ceil(energy * 0.2)
    @set({energy: energy})

  reacalculateUnits: ()->
    units = @_baseAssets()
    if @faction.megaCorp()
      units = units + Math.ceil(units * 0.2)
    @set({units: units})

  _baseAssets: ()->
    if @territoryCount() < 12
      return 3
    else
      bonus_assets = Math.floor((@territoryCount() - 9) / 3)
      return bonus_assets + 3
