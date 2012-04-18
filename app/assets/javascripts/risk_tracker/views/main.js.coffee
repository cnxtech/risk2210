class RiskTracker.Views.Main extends Backbone.View

  initialize: ()->
    _.bindAll(@, 'render')
    @collection.bind("reset", @render)
    #@collection.on('reset', @render, this)

  render: ()->
    skins = _.shuffle([1..6])
    @collection.each (game_player) =>
      view = new RiskTracker.Views.GamePlayer({model: game_player, attributes: {skin_number: skins.pop()}})
      $(@el).append(view.render().el)
    @
