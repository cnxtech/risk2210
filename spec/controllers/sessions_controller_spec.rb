require 'spec_helper'

describe SessionsController do

  let(:player) { FactoryGirl.create(:player, password: "secret1", password_confirmation: "secret1") }

  describe "destroy" do
    it "should log the user out" do
      login player

      delete :destroy

      session[:player_id].nil?.should == true
      response.should redirect_to root_path
      flash[:notice].should_not be_nil
    end
  end

  describe "new" do
    it "should have a session object" do
      get :new

      assigns(:session).should_not be_nil
      assigns(:page_title).should_not be_nil
    end
  end

  describe "create" do
    it "should login the user if valid credentials are submitted" do
      post :create, session: {email: player.email, password: "secret1", remember_me: "0"}

      response.should redirect_to new_game_path
      flash.now[:notice].should_not be_nil
    end
    it "should reload the new page if invalid credentials are submitted" do
      post :create, session: {email: player.email, password: "", remember_me: "0"}

      assigns(:session).should_not be_nil
      assigns(:page_title).should_not be_nil
      flash.now[:alert].should_not be_nil
      response.should render_template :new
    end
    it "should set the remember me cookie" do
      post :create, session: {email: player.email, password: "secret1", remember_me: "1"}

      cookies.signed[:remeber_me_token].should == player.remember_me_token
    end
  end

  describe "authenticate_facebook" do

    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    context "registration" do
      it "should authenticate a user via Facebook Connect" do
        expect{
          get :authenticate_facebook
        }.to change(Player, :count).by(1)

        response.should redirect_to new_game_path
        flash[:notice].should_not be_nil
      end
    end
    context "logging in" do
      it "should login a user" do
        player = FacebookAuthenticationService.new(OmniAuth.config.mock_auth[:facebook]).authenticate

        expect{
          get :authenticate_facebook
        }.to change(Player, :count).by(0)

        response.should redirect_to new_game_path
        flash[:notice].should_not be_nil
      end
    end
    context "attaching facebook authencation info to an existing user" do
      it "should update the existing user with Facebook's info" do
        player = FactoryGirl.create(:player, email: "payton@dog.com")

        expect{
          get :authenticate_facebook
        }.to change(Player, :count).by(0)

        player.reload.uid.should_not be_nil
        response.should redirect_to new_game_path
        flash[:notice].should_not be_nil
      end
    end
  end

  describe "failure" do
    it "should redirect the user to the root path with the error message from Facebook Connect" do
      get :failure, message: "Something went wrong!"

      response.should redirect_to root_path
      flash[:alert].should == "Facebook authentication error: Something went wrong!"
    end
  end

end
