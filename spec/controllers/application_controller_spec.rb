require 'spec_helper'

describe ApplicationController do

  let(:player) { FactoryGirl.create(:player) }

  describe "current_player" do
    it "returns the currently logged in player" do
      session[:player_id] = player.id

      controller.current_player.should == player
    end
    it "returns nil if no player is logged in" do
      controller.current_player.should == nil
    end
  end

  describe "login" do

    controller do
      def index
        player = Player.where(id: params[:player_id]).first
        login(player, redirect_to: root_path, remember_me: "1", notice: "Welcome!")
      end
    end

    it "sets the players's id in the session, remember me token in cookies, and redirects" do
      get :index, player_id: player.id

      session[:player_id].should == player.id
      response.should redirect_to root_path
      cookies.signed[:remember_me_token].should == player.remember_me_token
      flash.notice.should == "Welcome!"
    end
  end

  describe "logout" do
    it "sets the user's id in session to be nil" do
      session[:player_id] = player.id
      cookies[:remember_me_token] = player.remember_me_token

      controller.send(:logout)

      session[:player_id].should == nil
      cookies[:remember_me_token].should == nil
    end
  end

  describe "login_required" do

    controller do
      def index
        login_required
      end
    end

    it "redirects to the homepage, stores the original destination and has an alert message if there is no player" do
      get :index

      response.should redirect_to login_path
      session[:return_to_path].should_not be_nil
      flash[:alert].should_not == nil      
    end
  end

  describe "redirect_back_or_default" do
    
    controller do
      def index
        redirect_back_or_default(root_path)
      end
    end

    it "redirects back to where the player was coming from" do
      session[:return_to_path] = "/games/new"

      get :index

      response.should redirect_to "/games/new"
    end
    it "redirects to a default place if no destination was set" do
      session[:return_to_path] = nil

      get :index

      response.should redirect_to root_path
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

      controller.active_tab.should == :games
    end
  end

end
