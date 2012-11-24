class RiskTracker.Views.Map extends Backbone.View

  template: JST['risk_tracker/templates/map']

  render: ()->
    @$el.html(@template({map: @model}))
    return @
