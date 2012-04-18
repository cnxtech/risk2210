# class RiskTracker.Routers.Game extends Backbone.Router
#   routes:
#     '': 'index'
#     '/games/:id': 'show'

#   initialize: ->
#     @collection = new RiskTracker.Collections.Factions()
#     @collection.fetch()

#   index: ->
#     view = new RiskTracker.Views.GameIndex(collection: @collection)
#     $('#container').html(view.render().el)

#   show: (id) ->
#     alert "Faction #{id}"