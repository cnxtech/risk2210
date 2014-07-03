require 'rails_helper'

describe ApplicationController do

  let(:player) { FactoryGirl.create(:player) }

  describe "current_player" do
    it "returns the currently logged in player" do
      session[:player_id] = player.id

      expect(controller.current_player).to eq(player)
    end
    it "returns nil if no player is logged in" do
      expect(controller.current_player).to be_nil
    end
  end

  describe "login" do

    controller do
      def index
        player = Player.where(id: params[:player_id]).first
        login(player, redirect_to: "/", remember_me: "1", notice: "Welcome!")
      end
    end

    it "sets the players's id in the session, remember me token in cookies, and redirects" do
      routes.draw { get "index" => "anonymous#index" }
      allow(controller).to receive(:new_game_path).and_return("/")

      get :index, player_id: player.id

      expect(session[:player_id]).to eq(player.id.to_s)
      expect(response).to redirect_to("/")
      expect(cookies.signed[:remember_me_token]).to eq(player.remember_me_token)
      expect(flash.notice).to eq("Welcome!")
    end
  end

  describe "logout" do
    it "sets the user's id in session to be nil" do
      session[:player_id] = player.id
      cookies[:remember_me_token] = player.remember_me_token

      controller.send(:logout)

      expect(session[:player_id]).to be_nil
      expect(cookies[:remember_me_token]).to be_nil
    end
  end

  describe "login_required" do

    controller do
      def index
        login_required
      end
    end

    context "html request" do
      it "redirects to the homepage, stores the original destination and has an alert message if there is no player" do
        routes.draw { get "index" => "anonymous#index" }
        login_path = "/login"
        allow(controller).to receive(:login_path).and_return(login_path)

        get :index

        expect(response).to redirect_to(login_path)
        expect(session[:return_to_path]).to eq("http://test.host/index")
        expect(flash[:alert]).to_not be_nil
      end
    end
    context "json request" do
      it "responds with a 401" do
        routes.draw { get "index" => "anonymous#index" }

        get :index, format: :json

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(401)
        expect(json[:errors]).to include("You need to be logged in!")
      end
    end
  end

  describe "redirect_back_or_default" do

    controller do
      def index
        redirect_back_or_default("/")
      end
    end

    before do
      routes.draw { get "index" => "anonymous#index" }
    end

    it "redirects back to where the player was coming from" do
      session[:return_to_path] = "/games/new"

      get :index

      expect(response).to redirect_to("/games/new")
    end
    it "redirects to a default place if no destination was set" do
      session[:return_to_path] = nil

      get :index

      expect(response).to redirect_to("/")
    end
  end

  describe "active_tab" do
    controller do

      active_tab :games

      def index
        render text: "foo bar"
      end
    end

    it "should have the active tab set" do
      get :index

      expect(controller.active_tab).to eq(:games)
    end
  end

end
