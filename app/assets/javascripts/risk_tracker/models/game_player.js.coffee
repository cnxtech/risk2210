class RiskTracker.Models.GamePlayer extends Backbone.Model

  initialize: ()->
    @player = new RiskTracker.Models.Player(@get("player"))
    @faction = new RiskTracker.Models.Faction(@get("faction"))
    @continents = new RiskTracker.Collections.Continents()
    @turns = new RiskTracker.Collections.Turns()
    
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

  saveTurn: ()->
    @turns.create({game_player_id: @get("id"), units_collected: @units(), energy_collected: @energy(), territories_held: @territoryCount(), continent_ids: @_continentIds(), game_id: window.GameId})

  _continentIds: ()->
    @continents.pluck("id")

  _recalculateResources: ()->
    @_recalculateEnergy()
    @_reacalculateUnits()
      
  _recalculateEnergy: ()->
    energy = @_baseResources()
    energy = energy + @_continentalBonuses()
    if @faction.fusionConservancy()
      energy = energy + Math.ceil(energy * 0.2)
    @set({energy: energy})

  _reacalculateUnits: ()->
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
