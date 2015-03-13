class RiskTracker.Views.Game extends Backbone.View

  el: "#game"
  gamePlayerCards: []
  landModal: null
  waterModal: null
  lunarModal: null
  turnOrderModal: null
  colonyBonusModal: null

  events:
    "click .adjust-turn-order": "adjustTurnOrder"

  initialize: (gameData)->
    @model = new RiskTracker.Models.Game(gameData)
    @maps = @model.maps
    @model.turns.on "add", (turn) => @_updateProgressBar()
    @bind("start-new-year", @startNewYear)

  render: ()->
    skins = _.shuffle([1..8])

    @model.gamePlayers.each (gamePlayer) =>
      style_class = "player-card #{gamePlayer.get('color').toLowerCase()}-glow background-#{skins.pop()}"
      view = new RiskTracker.Views.GamePlayer({model: gamePlayer, game: @model, gameView: @, attributes: {class: style_class}})
      @gamePlayerCards.push(view)
      @$el.append(view.render().el)

    @landModal  = new RiskTracker.Views.Continents({collection: @maps, type: "land", game: @model, attributes: {class: "modal fade", id: "land-continents"}})
    @waterModal = new RiskTracker.Views.Continents({collection: @maps, type: "water", game: @model, attributes: {class: "modal fade", id: "water-continents"}})
    @lunarModal = new RiskTracker.Views.Continents({collection: @maps, type: "lunar", game: @model, attributes: {class: "modal fade", id: "lunar-continents"}})

    @$el.append(@landModal.render().el)
    @$el.append(@waterModal.render().el)
    @$el.append(@lunarModal.render().el)
    @$el.append(JST['risk_tracker/templates/game_controls'])

    @turnOrderModal = new RiskTracker.Views.TurnOrder({collection: @model.gamePlayers, gameView: @, attributes: {class: "modal fade", id: "turn-order-modal"}})
    @$el.append(@turnOrderModal.render().el)

    @colonyBonusModal = new RiskTracker.Views.ColonyBonus({model: @model, attributes: {class: "modal hide fade", id: "colony-bonus-modal"}})
    @$el.append(@colonyBonusModal.render().el)

    @activatePlayer(@model.currentPlayer)

    return @

  activatePlayer: (game_player)=>
    _.each @gamePlayerCards, (view)=>
      if view.model is game_player
        @model.setCurrentPlayer(game_player)
        view.showTurnControls()
      else
        view.hideTurnControls()

  activateNextPlayer: ()->
    turn_order = @model.currentPlayer.get("turn_order")
    game_player = @model.gamePlayers.where(turn_order: turn_order + 1)[0]
    if game_player is undefined
      @_endYear()
    else
      @activatePlayer(game_player)

  showContinents: (player, continentType)->
    if continentType is "land"
      @landModal.activate(player)
    else if continentType is "water"
      @waterModal.activate(player)
    else if continentType is "lunar"
      @lunarModal.activate(player)

  _updateProgressBar: () =>
    bar = @$el.find("#game-progress-bar")
    number_of_years = @model.get("number_of_years")
    number_of_players = @model.gamePlayers.length

    percent_complete = ((@model.turnCount() / (number_of_years * number_of_players)) * 100)
    bar.css({width: "#{percent_complete}%"})
    bar.attr({"aria-valuenow", "#{percent_complete}"})
    bar.find("span").text("#{percent_complete}% Complete")

  _endYear: ()=>
    if @model.lastYear()
      @colonyBonusModal.activate()
    else
      @turnOrderModal.activate()

  startNewYear: ()->
    next_player = @model.gamePlayers.where(turn_order: 1)[0]
    @model.startYear()
    @activatePlayer(next_player)
    @$el.find("#year-counter").text(@model.get("current_year"))

  adjustTurnOrder: (event)->
    event.preventDefault()
    @turnOrderModal.activate("adjustment")

  updateTurnOrder: ()->
    next_player = @model.gamePlayers.where(turn_order: 1)[0]
    @model.updateTurnOrder()
    @activatePlayer(next_player)
