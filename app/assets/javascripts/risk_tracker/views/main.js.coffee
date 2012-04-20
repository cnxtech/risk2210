class RiskTracker.Views.Main extends Backbone.View

  initialize: ()->
    _.bindAll(@, 'render')
    @game_players = window.GamePlayers
    @maps = window.Maps
    @game_players.bind("reset", @render)
    @maps.bind("reset", @render)

  render: ()->
    skins = _.shuffle([1..6])
    @game_players.each (game_player) =>
      view = new RiskTracker.Views.GamePlayer({model: game_player, attributes: {skin_number: skins.pop()}})
      $(@el).append(view.render().el)
    
    @maps.each (map) =>
      view = new RiskTracker.Views.Map({model: map})
      $("#maps").append(view.render().el)

    $(document).ready ->
      $("body").find(".continent-list").sortable
        cursor: 'move'
        items: 'li'
        scroll: true
        opacity: 0.5
        dropOnEmpty: true
        tolerance: 'pointer'
        connectWith: ".continent-list"
        update: ()->
          console.log "Dropped!"

    @
