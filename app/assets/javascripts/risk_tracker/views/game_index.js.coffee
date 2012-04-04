class RiskTracker.Views.GameIndex extends Backbone.View
  template: JST['risk_tracker/templates/games/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(factions: @collection))
    this