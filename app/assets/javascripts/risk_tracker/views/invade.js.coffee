class RiskTracker.Views.Invade extends Backbone.View

  template: JST['risk_tracker/templates/invade']

  initialize: ()->
    console.log "init"

  render: ()->
    @$el.html(@template({model: @model}))
    return @

