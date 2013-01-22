class RiskTracker.Models.GamePlayer extends Backbone.Model

  currentTurnOrder: null

  initialize: ()->
    @player = new RiskTracker.Models.Player(@get("player"))
    @faction = new RiskTracker.Models.Faction(@get("faction"))
    @continents = new RiskTracker.Collections.Continents()
    @currentTurnOrder = @get("turn_order")

    @bind("change:territory_count", @_calculateResources)
    @continents.on "add", (continent) => @_calculateResources()
    @continents.on "remove", (continent) => @_calculateResources()
    @_calculateResources()

  territoryCount: ()->
    @get("territory_count")

  energy: ()->
    @get("energy")

  units: ()->
    @get("units")

  addContinent: (continent)->
    @continents.add(continent)
    @game.availableContinents.remove(continent)

  removeContinent: (continent)->
    @continents.remove(continent)
    @game.availableContinents.add(continent)

  incrementTerritoryCount: ()->
    @set({territory_count: @territoryCount() + 1})

  decrementTerritoryCount: ()->
    if @territoryCount() > 0
      @set({territory_count: @territoryCount() - 1})

  landContinents: ()->
    @continents.land()

  waterContinents: ()->
    @continents.water()

  lunarContinents: ()->
    @continents.lunar()

  borderGlow: ()->
    @energy() * 5

  turnOrder: ()->
    @currentTurnOrder

  hasContinent: (continentId)->
    _.contains(@continentIds(), continentId)

  continentIds: ()->
    @continents.pluck("id") || []

  _calculateResources: ()->
    @_calculateEnergy()
    @_calculateUnits()

  _calculateEnergy: ()->
    energy = @_baseResources()
    energy = energy + @_continentalBonuses()
    if @faction.fusionConservancy()
      energy = energy + Math.ceil(energy * 0.2)
    @set({energy: energy})

  _calculateUnits: ()->
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

  setStartingContinents: ()->
    _(@get("continent_ids")).each (continent_id) =>
      continent = @game.maps.findContinentById(continent_id)
      @continents.add(continent)
      @game.availableContinents.remove(continent)
