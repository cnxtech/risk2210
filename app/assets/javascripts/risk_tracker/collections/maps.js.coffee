class RiskTracker.Collections.Maps extends Backbone.Collection
  model: RiskTracker.Models.Map

  findContinentById: (continent_id)->
    continents = _.map @models, (map)->
      return map.continents.models
    
    continents = _.flatten(continents)
    
    _.find continents, (continent)->
      continent.get('id') is continent_id
