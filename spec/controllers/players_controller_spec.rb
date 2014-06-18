require 'rails_helper'

describe PlayersController do

  let(:player) { FactoryGirl.create(:player) }
  let(:other_player) { FactoryGirl.create(:player) }

  describe "authorization" do
    it "only allows the logged in player edit, update, and destroy" do
      login player

      {put: :update, get: :edit, delete: :destroy}.each do |verb, action|
        send(verb, action, id: other_player.slug, player: {})

        expect(response).to redirect_to root_path
        expect(flash.alert).to_not be_nil
      end
    end
  end

  describe "index" do
    it "should have all players with public profiles" do
      private_player = FactoryGirl.create(:player, public_profile: false)

      get :index

      expect(assigns(:players)).to include(player)
      expect(assigns(:players)).to_not include(private_player)
      expect(assigns(:page_title)).to_not be_nil
    end
  end

  describe "show" do
    context "html" do
      it "should have the requested player" do
        game = FactoryGirl.create(:game, creator: player)

        get :show, id: player.slug

        expect(assigns(:player)).to eq(player)
        expect(assigns(:page_title)).to_not be_nil
      end
    end
    context "json" do
      it "should render the player json" do
        get :show, id: player.slug, format: :json

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:id]).to_not be_nil
      end
    end
    context "player not found" do
      it "should render the 404 page" do
        get :show, id: "foo"

        expect(response.status).to eq(404)
      end
    end
  end

  describe "destroy" do
    it "should delete the player's account" do
      login player

      allow(controller).to receive(:logout).once
      expect{
        delete :destroy, id: player.slug
      }.to change(Player, :count).by(-1)

      expect(response).to redirect_to root_path
      expect(flash.notice).to_not be_nil
    end
  end

  describe "new" do
    it "should have a player object" do
      get :new

      expect(assigns(:player)).to_not be_nil
      expect(assigns(:player)).to be_new_record
      expect(assigns(:page_title)).to_not be_nil
    end
  end

  describe "edit" do
    it "should have the requested player" do
      login player

      get :edit, id: player.slug

      expect(assigns(:player)).to eq(player)
      expect(assigns(:page_title)).to_not be_nil
    end
  end

  describe "update" do
    before { login player }
    context "html requests" do
      it "should update the player and redirect if all fields are valid" do
        put :update, id: player.slug, player: {bio: "My updated bio"}

        expect(response).to redirect_to player_path(player)
        expect(flash.notice).to_not be_nil
      end
      it "should reload the page if errors were present" do
        put :update, id: player.slug, player: {handle: ""}

        expect(response).to render_template(:edit)
        expect(flash.now[:alert]).to_not be_nil
      end
    end
    context "json requests" do
      it "should update the player and return success if all fields are valid" do
        put :update, id: player.slug, player: {bio: "My updated bio"}, format: :json

        expect(response).to be_success
      end
      it "should return a 400 and an array of errors if the update fails" do
        put :update, id: player.slug, player: {handle: ""}, format: :json

        json = JSON.parse(response.body)

        expect(response).to_not be_success
        expect(json).to be_a(Array)
      end
    end
  end

  describe "create" do
    it "should create a player" do
      post :create, player: FactoryGirl.attributes_for(:player)

      expect(response).to redirect_to edit_player_path(assigns(:player))
      expect(flash.notice).to_not be_nil
    end
    it "should reload the page if errors are present" do
      post :create, player: {handle: ""}

      expect(response).to render_template(:new)
      expect(flash.now[:alert]).to_not be_nil
      expect(assigns(:page_title)).to_not be_nil
    end
  end

end
