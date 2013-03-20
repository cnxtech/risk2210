require 'spec_helper'

describe PasswordResetController do

  describe "index" do
    it "should render the forgot password form" do
      get :index

      response.should be_success
    end
  end

  describe "create" do
    context "success" do
      it "should should deliver the email and redirect the player to the homepage" do
        player = FactoryGirl.create(:player)

        post :create, player: {email: player.email}

        response.should redirect_to root_path
        flash.notice.should_not be_nil
      end
    end
    context "failure" do
      it "reload the page if no player was found" do
        post :create, player: {email: "payton@gmail.com"}

        response.should redirect_to forgot_password_path
        flash.alert.should_not be_nil
      end
    end
  end

  describe "show" do
    context "token found" do
      it "should display the form to update the player's password" do
        token = SecureRandom.hex(8)
        player = FactoryGirl.create(:player, password_reset_token: token)

        get :show, token: token

        response.should be_success
      end
    end
    context "token not found" do
      it "should redirect to the homepage and display a message that the token wasn't found" do
        get :show, token: "foobar"

        response.should redirect_to root_path
        flash.alert.should_not be_nil
      end
    end
  end

  describe "update" do
    before do
      @token = SecureRandom.hex(8)
      @player = FactoryGirl.create(:player, password_reset_token: @token)
    end
    context "success" do
      it "should update the password and login the user" do
        put :update, token: @token, player: {password: "password1", password_confirmation: "password1"}

        response.should redirect_to edit_player_path(@player)
        @player.reload.password_reset_token.should be_nil
        flash.notice.should_not be_nil
      end
    end
    context "failure" do
      it "redirect the user to the find password token page and display an error" do
        put :update, token: @token, player: {password: "foo", password_confirmation: "bar"}

        response.should redirect_to find_password_reset_path(@token)
        flash.alert.should_not be_nil
      end
    end
  end

end
