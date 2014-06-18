require 'rails_helper'

describe PasswordResetController do

  describe "index" do
    it "should render the forgot password form" do
      get :index

      expect(response).to be_success
    end
  end

  describe "create" do
    context "success" do
      it "should should deliver the email and redirect the player to the homepage" do
        player = FactoryGirl.create(:player)

        post :create, player: {email: player.email}

        expect(response).to redirect_to root_path
        expect(flash.notice).to_not be_nil
      end
    end
    context "failure" do
      it "reload the page if no player was found" do
        post :create, player: {email: "payton@gmail.com"}

        expect(response).to redirect_to forgot_password_path
        expect(flash.alert).to_not be_nil
      end
    end
  end

  describe "show" do
    context "token found" do
      it "should display the form to update the player's password" do
        token = SecureRandom.hex(8)
        player = FactoryGirl.create(:player, password_reset_token: token)

        get :show, token: token

        expect(response).to be_success
      end
    end
    context "token not found" do
      it "should redirect to the homepage and display a message that the token wasn't found" do
        get :show, token: "foobar"

        expect(response).to redirect_to root_path
        expect(flash.alert).to_not be_nil
      end
    end
  end

  describe "update" do

    let(:token) { SecureRandom.hex(8) }
    let!(:player) { FactoryGirl.create(:player, password_reset_token: token) }

    context "success" do
      it "should update the password and login the user" do
        put :update, token: token, player: {password: "password1", password_confirmation: "password1"}

        expect(response).to redirect_to edit_player_path(player)
        expect(player.reload.password_reset_token).to be_nil
        expect(flash.notice).to_not be_nil
      end
    end
    context "failure" do
      it "redirect the user to the find password token page and display an error" do
        put :update, token: token, player: {password: "foo", password_confirmation: "bar"}

        expect(response).to redirect_to find_password_reset_path(token)
        expect(flash.alert).to_not be_nil
      end
    end
  end

end
