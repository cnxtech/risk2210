require 'spec_helper'

describe GamesController do

  let(:player) { FactoryGirl.create(:player) }

  describe "index" do
    it "should a listing of all games" do
      pending
    end
  end

  describe "new" do
    it "should render a form and have 2 game players" do
      login player

      get :new

      assigns(:game).should_not be_nil
      assigns(:game).game_players.first.player.should == player
      assigns(:game).game_players.second.should_not be_nil
    end
  end

  describe "create" do
    it "should description" do
      pending
    end
  end

  describe "show" do
    it "should description" do
      pending
    end
  end

end
