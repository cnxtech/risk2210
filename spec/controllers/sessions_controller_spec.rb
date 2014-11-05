require 'rails_helper'

describe SessionsController do

  let(:player) { FactoryGirl.create(:player, password: "secret1", password_confirmation: "secret1") }

  describe "destroy" do
    it "should log the user out" do
      login player

      delete :destroy

      expect(session[:player_id]).to be_nil
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to_not be_nil
    end
  end

  describe "new" do
    it "should have a session object" do
      get :new

      expect(assigns(:session)).to_not be_nil
    end
  end

  describe "create" do
    it "should login the user if valid credentials are submitted" do
      post :create, session: {email: player.email, password: "secret1", remember_me: "0"}

      expect(response).to redirect_to new_game_path
      expect(flash.now[:notice]).to_not be_nil
    end
    it "should reload the new page if invalid credentials are submitted" do
      post :create, session: {email: player.email, password: "", remember_me: "0"}

      expect(assigns(:session)).to_not be_nil
      expect(flash.now[:alert]).to_not be_nil
      expect(response).to render_template :new
    end
    it "should set the remember me cookie" do
      post :create, session: {email: player.email, password: "secret1", remember_me: "1"}

      expect(cookies.signed[:remeber_me_token]).to eq(player.remember_me_token)
    end
  end

  describe "authenticate_facebook" do

    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    context "registration" do
      it "should authenticate a user via Facebook Connect" do
        expect{
          get :authenticate_facebook, provider: "facebook"
        }.to change(Player, :count).by(1)

        expect(response).to redirect_to new_game_path
        expect(flash[:notice]).to_not be_nil
      end
    end
    context "logging in" do
      it "should login a user" do
        player = Authentication::Facebook.new(OmniAuth.config.mock_auth[:facebook]).authenticate

        expect{
          get :authenticate_facebook, provider: "facebook"
        }.to change(Player, :count).by(0)

        expect(response).to redirect_to new_game_path
        expect(flash[:notice]).to_not be_nil
      end
    end
    context "attaching facebook authencation info to an existing user" do
      it "should update the existing user with Facebook's info" do
        player = FactoryGirl.create(:player, email: "payton@dog.com")

        expect{
          get :authenticate_facebook, provider: "facebook"
        }.to change(Player, :count).by(0)

        expect(player.reload.uid).to_not be_nil
        expect(response).to redirect_to new_game_path
        expect(flash[:notice]).to_not be_nil
      end
    end
  end

  describe "failure" do
    it "should redirect the user to the root path with the error message from Facebook Connect" do
      get :failure, message: "Something went wrong!"

      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eq("Facebook authentication error: Something went wrong!")
    end
  end

end
