class RiskTracker.Views.Invade extends Backbone.View

  template: JST['risk_tracker/templates/invade']

  className: "invade-card"

  events:
    "click .end-invasion": "endInvasion"

  initialize: ()->
    console.log "invade init"

  render: ()->
    @$el.html(@template({model: @model}))
    return @

  endInvasion: (event)->
    event.preventDefault()

    @$el.siblings().show()
    @$el.hide()

