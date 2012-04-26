class RiskTracker.Views.Main extends Backbone.View

  initialize: ()->
    _.bindAll(@, 'render')
    @gamePlayers = window.Game.gamePlayers
    @maps = window.Game.maps
    @gamePlayers.bind("reset", @render)
    @maps.bind("reset", @render)
    window.Game.bind("change:turn_count", @_updateProgressBar)

  render: ()->
    @_setupContinents()
    skins = _.shuffle([1..8])
    @gamePlayers.each (gamePlayer) =>
      view = new RiskTracker.Views.GamePlayer({model: gamePlayer, attributes: {skin_number: skins.pop()}})
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
    number_of_players = window.Game.gamePlayers.length
    turn_count = window.Game.get("turn_count")

    percent_complete = ((turn_count / (number_of_years * number_of_players)) * 100)
    bar.css({width: "#{percent_complete}%"})

  _setupContinents: () ->
    claimed_continents = [] 
    @gamePlayers.each (gamePlayer) -> 
      gamePlayer.setStartingContinents()
      claimed_continents.push(gamePlayer.continents.models)
    
    claimed_continents = _(claimed_continents).flatten()
    
    @maps.each (map) ->
      map.continents.each (continent)->
        if _.include(claimed_continents, continent)
          continent.set({hidden: true})
