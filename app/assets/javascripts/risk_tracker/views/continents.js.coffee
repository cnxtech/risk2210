class RiskTracker.Views.Continents extends Backbone.View

  template: JST['risk_tracker/templates/continents']

  events:
    "click .unclaimed .continent": "addContinent"
    "click .claimed .continent":   "removeContinent"

  initialize: ()->
    @game = @options.game
    @type = @options.type

  render: ()->
    @$el.html(@template({maps: @collection.models, type: @type}))
    return @

  addContinent: (event)->
    continentId = $(event.target).data('id')
    continent = @game.maps.findContinentById(continentId)
    @game.currentPlayer.addContinent(continent)
    @$el.modal('hide')

  removeContinent: (event)->
    continentId = $(event.target).data('id')
    continent = @game.maps.findContinentById(continentId)
    @game.currentPlayer.removeContinent(continent)
    @$el.modal('hide')
