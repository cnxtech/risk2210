require 'spec_helper'

describe GamesController do

  let(:player1) { FactoryGirl.create(:player) }
  let(:player2) { FactoryGirl.create(:player) }
  let(:continent_ids) { Continent.all.map(&:id).sample(4) }
  let(:faction_ids) { Faction.all.map(&:id).sample(2) }
  let(:map_ids) { Map.all.map(&:id).sample(2) }

  describe "new" do
    it "should render a form and have 2 game players" do
      login player1

      get :new

      assigns(:game).should_not be_nil
      assigns(:game).game_players.first.handle.should == player1.handle
      assigns(:game).game_players.second.should_not be_nil
    end
  end

  describe "create" do
    it "should create a new game" do
      login player1

      ## Setup game
      game_players = {}
      game_players["0"] = {color: "Blue", handle: player1.handle, faction_id: faction_ids[0], starting_turn_order: 1}
      game_players["1"] = {color: "Green", handle: player2.handle, faction_id: faction_ids[1], starting_turn_order: 2}

      post :create, game: {game_players_attributes: game_players, map_ids: map_ids, location: "Chicago"}

      response.should redirect_to game_path(assigns(:game))
      assigns(:game).creator.should == player1
      flash[:notice].should_not be_nil
    end
    it "should reload the page if there were any errors" do
      login player1

      post :create, game: {game_players_attributes: {}, map_ids: [], location: "Chicago"}

      response.should render_template :new
      flash.now[:alert].should_not be_nil
    end
  end

  describe "show" do
    it "should description" do
      game_players = {}
      game_players["0"] = {color: "Blue", handle: player1.handle, faction_id: faction_ids[0], starting_turn_order: 1}
      game_players["1"] = {color: "Green", handle: player2.handle, faction_id: faction_ids[1], starting_turn_order: 2}
      game = FactoryGirl.create(:game, map_ids: map_ids, game_players_attributes: game_players)

      get :show, id: game

      response.should be_success
    end
  end

  describe "destroy" do
    before do
      game_players = {}
      game_players["0"] = {color: "Blue", handle: player1.handle, faction_id: faction_ids[0], starting_turn_order: 1}
      game_players["1"] = {color: "Green", handle: player2.handle, faction_id: faction_ids[1], starting_turn_order: 2}
      @game = FactoryGirl.create(:game, map_ids: map_ids, game_players_attributes: game_players, creator_id: player1.id)
    end
    it "should remove the game if the current player is the creator" do
      login player1

      expect{
        delete :destroy, id: @game.id
      }.to change(Game, :count).by(-1)

      response.should redirect_to root_path
      flash.notice.should_not be_nil
    end
    it "should display an alert if the current player is not the creator" do
      login player2

      expect{
        delete :destroy, id: @game.id
      }.to change(Game, :count).by(0)

      response.should redirect_to root_path
      flash.alert.should_not be_nil
    end
  end

end
