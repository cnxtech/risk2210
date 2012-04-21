class RiskTracker.Views.Main extends Backbone.View

  initialize: ()->
    _.bindAll(@, 'render')
    @game_players = window.Game.game_players
    @maps = window.Game.maps
    @game_players.bind("reset", @render)
    @maps.bind("reset", @render)
    window.Game.bind("change:turn_count", @_updateProgressBar)

  render: ()->
    skins = _.shuffle([1..8])
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

    return @

  _updateProgressBar: () ->
    bar = $("#game-progress-bar").find(".bar")
    number_of_years = window.Game.get("number_of_years")
    number_of_players = window.Game.game_players.length
    turn_count = window.Game.get("turn_count")

    percent_complete = ((turn_count / (number_of_years * number_of_players)) * 100)
    bar.css({width: "#{percent_complete}%"})
