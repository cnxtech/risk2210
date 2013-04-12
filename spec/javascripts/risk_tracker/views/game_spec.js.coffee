#= require application
#= require risk_tracker
#= require_tree ./../../fixtures

describe "RiskTracker.Views.Game", ()->

  beforeEach ()->
    @view = new RiskTracker.Views.Game(newGameData)

  describe "rendering", ()->
    it "should render", ()->
      html = @view.render().$el
      expect(html).toBeDefined()

