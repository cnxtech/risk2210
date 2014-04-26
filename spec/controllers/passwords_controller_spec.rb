require 'spec_helper'

describe PasswordsController do

  let(:player) { FactoryGirl.create(:player, password: "secret1", password_confirmation: "secret1") }

  describe "edit" do
    it "should have the player" do
      login player

      get :edit

      expect(assigns(:player)).to eq(player)
    end
  end

  describe "update" do
    it "should update the player's password" do
      login player

      put :update, player: {old_password: "secret1", password: "secret2", password_confirmation: "secret2"}

      expect(response).to redirect_to player_path(player)
      expect(flash[:notice]).to_not be_nil
    end
    it "should reload the page if the password doesn't update" do
      login player

      put :update, player: {old_password: "", password: "secret2", password_confirmation: "secret2"}

      expect(response).to render_template(:edit)
      expect(flash.now[:alert]).to_not be_nil
    end
  end
end
