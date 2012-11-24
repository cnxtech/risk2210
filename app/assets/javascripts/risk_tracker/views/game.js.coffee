class RiskTracker.Views.Game extends Backbone.View

  el: "#game"

  initialize: ()->
    @model = new RiskTracker.Models.Game(window.gameData)
    @maps = @model.maps

    @model.bind("change:turn_count", @_updateProgressBar)

  render: ()->
    @_setupContinents()
    skins = _.shuffle([1..8])
    @model.gamePlayers.each (gamePlayer) =>
      style_class = "player-card #{gamePlayer.get('color').toLowerCase()}-glow background-#{skins.pop()}"
      view = new RiskTracker.Views.GamePlayer({model: gamePlayer, attributes: {class: style_class, game: @model}})
      @$el.append(view.render().el)

    @maps.each (map) =>
      view = new RiskTracker.Views.Map({model: map, attributes: {class: "map"}})
      $("#maps").append(view.render().el)

    $(document).ready ->
      _(["land", "water", "lunar"]).each (type) ->
        $("body").find(".continent-list.#{type}").sortable
          cursor: 'move'
          items: 'li'
          scroll: true
          opacity: 0.5
          dropOnEmpty: true
          tolerance: 'pointer'
          connectWith: ".continent-list.#{type}"

    return @

  _updateProgressBar: () =>
    bar = $("#game-progress-bar").find(".bar")
    number_of_years = @model.get("number_of_years")
    number_of_players = @model.gamePlayers.length
    turn_count = @model.get("turn_count")

    percent_complete = ((turn_count / (number_of_years * number_of_players)) * 100)
    bar.css({width: "#{percent_complete}%"})

  _setupContinents: () ->
    claimed_continents = []
    @model.gamePlayers.each (gamePlayer) ->
      gamePlayer.setStartingContinents()
      claimed_continents.push(gamePlayer.continents.models)

    claimed_continents = _(claimed_continents).flatten()

    @maps.each (map) ->
      map.continents.each (continent)->
        if _.include(claimed_continents, continent)
          continent.set({hidden: true})
