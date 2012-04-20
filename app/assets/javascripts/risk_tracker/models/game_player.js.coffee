class RiskTracker.Models.GamePlayer extends Backbone.Model

  initialize: ()->
    @player = new RiskTracker.Models.Player(@get("player"))
    @faction = new RiskTracker.Models.Faction(@get("faction"))
    @continents = new RiskTracker.Collections.Continents()
    
    @set({territory_count: 0, energy: @faction.minEnergy(), units: @faction.minUnits()})
    
    @bind("change:territory_count", @_recalculateResources)
    @continents.on "add", (continent) => @_recalculateResources()
    @continents.on "remove", (continent) => @_recalculateResources()

  territoryCount: ()->
    @get("territory_count")

  energy: ()->
    @get("energy")

  units: ()->
    @get("units")

  addContinent: (continent)->
    @continents.add(continent)

  removeContinent: (continent)->
    @continents.remove(continent)

  incrementTerritoryCount: ()->
    @set({territory_count: @territoryCount() + 1})  

  decrementTerritoryCount: ()->
    if @territoryCount() > 0
      @set({territory_count: @territoryCount() - 1})

  _recalculateResources: ()->
    @recalculateEnergy()
    @reacalculateUnits()
      
  recalculateEnergy: ()->
    energy = @_baseResources()
    energy = energy + @_continentalBonuses()
    if @faction.fusionConservancy()
      energy = energy + Math.ceil(energy * 0.2)
    @set({energy: energy})

  reacalculateUnits: ()->
    units = @_baseResources()
    units = units + @_continentalBonuses()
    if @faction.megaCorp()
      units = units + Math.ceil(units * 0.2)
    @set({units: units})

  _baseResources: ()->
    if @territoryCount() < 12
      return 3
    else
      bonus_resources = Math.floor((@territoryCount() - 9) / 3)
      return bonus_resources + 3

  _continentalBonuses: ()->
    sum = _.inject(@continents.models, (memo, continent) ->
      memo + continent.get("bonus")
    , 0)
    return sum
