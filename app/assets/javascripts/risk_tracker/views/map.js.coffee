class RiskTracker.Views.Map extends Backbone.View

  template: JST['risk_tracker/templates/map']

  initialize: ()->
    _.bindAll(@, 'render')
    @model.bind("reset", @render)
    
  render: ()->
    $(@el).html(@template({map: @model}))
    @
