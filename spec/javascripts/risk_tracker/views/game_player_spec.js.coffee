#= require application
#= require risk_tracker

describe "RiskTracker.Views.GamePlayer", ()->

  beforeEach ()->
    @player = new RiskTracker.Models.Player()
    @faction = new RiskTracker.Models.Faction(name: "Havoc")
    @game = new RiskTracker.Models.Game()
    @gamePlayer = new RiskTracker.Models.GamePlayer(faction: @faction, player: @player)
    @view = new RiskTracker.Views.GamePlayer({model: @gamePlayer, attributes: {class: "player-card", game: @game}})

  describe "rendering", ()->
    it "should render", ()->
      html = @view.render().$el
      expect(html).toBeDefined()
