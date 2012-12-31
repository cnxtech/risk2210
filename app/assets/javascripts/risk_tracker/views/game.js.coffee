class RiskTracker.Views.Game extends Backbone.View

  el: "#game"

  initialize: ()->
    @model = new RiskTracker.Models.Game(window.gameData)
    @maps = @model.maps
    @_setupContinents()
    @model.bind("change:turn_count", @_updateProgressBar)

  render: ()->
    skins = _.shuffle([1..8])

    @model.gamePlayers.each (gamePlayer) =>
      style_class = "player-card #{gamePlayer.get('color').toLowerCase()}-glow background-#{skins.pop()}"
      view = new RiskTracker.Views.GamePlayer({model: gamePlayer, game: @model, attributes: {class: style_class}})
      @$el.append(view.render().el)

    _(['land', 'water', 'lunar']).each (type) =>
      view = new RiskTracker.Views.Continents({collection: @maps, type: type, game: @model, attributes: {class: "modal hide fade", id: "#{type}-continents"}})
      @$el.append(view.render().el)

    return @

  _updateProgressBar: () =>
    bar = $("#game-progress-bar").find(".bar")
    number_of_years = @model.get("number_of_years")
    number_of_players = @model.gamePlayers.length
    turn_count = @model.get("turn_count")

    percent_complete = ((turn_count / (number_of_years * number_of_players)) * 100)
    bar.css({width: "#{percent_complete}%"})

  _setupContinents: () ->
    @model.availableContinents = new RiskTracker.Collections.Continents(@maps.continents())

    @model.gamePlayers.each (gamePlayer) ->
      gamePlayer.setStartingContinents()
