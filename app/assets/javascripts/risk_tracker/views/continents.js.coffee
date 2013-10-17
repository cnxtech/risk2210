class RiskTracker.Views.Continents extends Backbone.View

  template: JST['risk_tracker/templates/continents']

  currentPlayer: null

  events:
    "click .unclaimed .continent": "addContinent"
    "click .claimed .continent":   "removeContinent"

  initialize: (@options={})->
    @game = @options.game
    @type = @options.type

  render: ()->
    @$el.html(@template({maps: @collection.models, type: @type}))
    return @

  addContinent: (event)->
    continentId = $(event.target).data('id')
    continent = @game.maps.findContinentById(continentId)
    @currentPlayer.addContinent(continent)
    @$el.modal('hide')

  removeContinent: (event)->
    continentId = $(event.target).data('id')
    continent = @game.maps.findContinentById(continentId)
    @currentPlayer.removeContinent(continent)
    @$el.modal('hide')

  activate: (player)->
    @currentPlayer = player

    @$el.find(".player-name").text(player.get("handle"))

    @$el.find(".claimed span.continent").each (index, span)=>
      label = $(span)
      continentId = label.data("id")
      if !player.hasContinent(continentId)
        label.hide()
      else
        label.show() if label.is(":hidden")

    @$el.find(".unclaimed span.continent").each (index, span)=>
      label = $(span)
      continentId = label.data("id")
      if player.hasContinent(continentId) or !@game.availableContinents.hasContinent(continentId)
        label.hide()
      else
        label.show() if label.is(":hidden")

    @$el.modal()
