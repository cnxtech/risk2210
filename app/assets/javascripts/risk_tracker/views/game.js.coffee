class RiskTracker.Views.Game extends Backbone.View

  el: "#game"
  gamePlayerCards: []

  initialize: ()->
    @model = new RiskTracker.Models.Game(window.gameData)
    @maps = @model.maps
    @_setupContinents()
    @model.turns.on "add", (turn) => @_updateProgressBar()

  render: ()->
    skins = _.shuffle([1..8])

    @model.gamePlayers.each (gamePlayer) =>
      style_class = "player-card #{gamePlayer.get('color').toLowerCase()}-glow background-#{skins.pop()}"
      view = new RiskTracker.Views.GamePlayer({model: gamePlayer, game: @model, gameView: @, attributes: {class: style_class}})
      @gamePlayerCards.push(view)

      @$el.append(view.render().el)

    _(['land', 'water', 'lunar']).each (type) =>
      view = new RiskTracker.Views.Continents({collection: @maps, type: type, game: @model, attributes: {class: "modal hide fade", id: "#{type}-continents"}})
      @$el.append(view.render().el)

    @activatePlayer(@model.currentPlayer)

    return @

  activatePlayer: (game_player)->
    _.each @gamePlayerCards, (view)->
      if view.model is game_player
        view.showTurnControls()
      else
        view.hideTurnControls()

  activateNextPlayer: ()->
    turn_order = @model.currentPlayer.get("turn_order")
    game_player = @model.gamePlayers.where(turn_order: turn_order + 1)[0]
    if game_player is undefined
      alert "End year!"
    else
      @activatePlayer(game_player)

  _updateProgressBar: () =>
    bar = $("#game-progress-bar").find(".bar")
    number_of_years = @model.get("number_of_years")
    number_of_players = @model.gamePlayers.length

    percent_complete = ((@model.turnCount() / (number_of_years * number_of_players)) * 100)
    bar.css({width: "#{percent_complete}%"})

  _setupContinents: () ->
    @model.availableContinents = new RiskTracker.Collections.Continents(@maps.continents())

    @model.gamePlayers.each (gamePlayer) ->
      gamePlayer.setStartingContinents()
