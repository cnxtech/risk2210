require 'spec_helper'

describe PlayersController do

  let(:player) { FactoryGirl.create(:player) }

  describe "authorization" do
    it "only allows the logged in player edit, update, and destroy" do
      other_player = FactoryGirl.create(:player)
      login player

      {put: :update, get: :edit, delete: :destroy}.each do |verb, action|
        send(verb, action, id: other_player.slug, player: {})

        response.should redirect_to root_path
        flash.alert.should_not be_nil
      end

    end
  end

  describe "index" do
    it "should have all players with public profiles" do
      private_player = FactoryGirl.create(:player, public_profile: false)

      get :index

      assigns(:players).include?(player).should == true
      assigns(:players).include?(private_player).should == false
      assigns(:page_title).should_not be_nil
    end
  end

  describe "show" do
    context "html" do
      it "should have the requested player" do
        game = FactoryGirl.build(:game, creator: player)
        game.game_players << FactoryGirl.build(:game_player, turn_order: 3, handle: player.handle)
        game.save

        get :show, id: player.slug

        assigns(:player).should == player
        assigns(:page_title).should_not be_nil
      end
    end
    context "json" do
      it "should render the player json" do
        get :show, id: player.slug, format: :json

        json = JSON.parse(response.body, symbolize_names: true)

        json[:id].should_not be_nil
      end
    end
    context "player not found" do
      it "should render the 404 page" do
        get :show, id: "foo"

        response.status.should == 404
      end
    end
  end

  describe "destroy" do
    it "should delete the player's account" do
      login player

      controller.should_receive(:logout).once
      expect{
        delete :destroy, id: player.slug
      }.to change(Player, :count).by(-1)

      response.should redirect_to root_path
      flash.notice.should_not be_nil
    end
  end

  describe "new" do
    it "should have a player object" do
      get :new

      assigns(:player).should_not be_nil
      assigns(:player).new_record?.should == true
      assigns(:page_title).should_not be_nil
    end
  end

  describe "edit" do
    it "should have the requested player" do
      login player

      get :edit, id: player.slug

      assigns(:player).should == player
      assigns(:page_title).should_not be_nil
    end
  end

  describe "update" do
    before do
      login player
    end
    context "html requests" do
      it "should update the player and redirect if all fields are valid" do
        put :update, id: player.slug, player: {bio: "My updated bio"}

        response.should redirect_to player_path(player)
        flash.notice.should_not be_nil
      end
      it "should reload the page if errors were present" do
        put :update, id: player.slug, player: {handle: ""}

        response.should render_template(:edit)
        flash.now[:alert].should_not be_nil
      end
    end
    context "json requests" do
      it "should update the player and return success if all fields are valid" do
        put :update, id: player.slug, player: {bio: "My updated bio"}, format: :json

        response.should be_success
      end
      it "should return a 400 and an array of errors if the update fails" do
        put :update, id: player.slug, player: {handle: ""}, format: :json

        response.should_not be_success
        JSON.parse(response.body).instance_of?(Array).should == true
      end
    end
  end

  describe "create" do
    it "should create a player" do
      post :create, player: FactoryGirl.attributes_for(:player)

      response.should redirect_to edit_player_path(assigns(:player))
      flash.notice.should_not be_nil
    end
    it "should reload the page if errors are present" do
      post :create, player: {handle: ""}

      response.should render_template(:new)
      flash.now[:alert].should_not be_nil
      assigns(:page_title).should_not be_nil
    end
  end

end
