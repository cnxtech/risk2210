class RiskTracker.Collections.GamePlayers extends Backbone.Collection
  model: RiskTracker.Models.GamePlayer

  find: (id)->
    @where(id: id)[0]
