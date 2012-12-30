class RiskTracker.Collections.Maps extends Backbone.Collection
  model: RiskTracker.Models.Map

  findContinentById: (continent_id)->
    _.find @continents(), (continent)->
      continent.get('id') is continent_id

  continents: ()->
    continents = _.map @models, (map)->
      return map.continents.models

    _.flatten(continents)

  continentIds: ()->
    _(@continents()).pluck("id")
