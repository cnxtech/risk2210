require 'spec_helper'

describe PasswordsController do

  let(:player) { FactoryGirl.create(:player, password: "secret1", password_confirmation: "secret1") }

  describe "edit" do
    it "should have the player" do
      login player

      get :edit

      assigns(:player).should == player
    end
  end

  describe "update" do
    it "should update the player's password" do
      login player

      put :update, player: {old_password: "secret1", password: "secret2", password_confirmation: "secret2"}

      response.should redirect_to player_path(player)
      flash[:notice].should_not be_nil
    end
    it "should reload the page if the password doesn't update" do
      login player

      put :update, player: {old_password: "", password: "secret2", password_confirmation: "secret2"}

      response.should render_template :edit
      flash.now[:alert].should_not be_nil      
    end
  end
end
