require 'spec_helper'

describe Authentication::Facebook do

  let(:player1) { Fixtures::Facebook.player1 }
  let(:player2) { Fixtures::Facebook.player2 }
  let(:me) { Fixtures::Facebook.me }

  describe "registering using Facebook" do
    context "player doesn't already have an account" do
      it "registers me with my Facebook omniath hash" do
        player = Authentication::Facebook.new(Fixtures::Facebook.me).authenticate

        expect(player).to be_valid
        expect(player).to_not be_new_record
        expect(player.raw_authorization).to eq(Fixtures::Facebook.me)
      end
      it "registers player1 with their facebook data" do
        player = Authentication::Facebook.new(player1).authenticate

        expect(player).to be_valid
        expect(player).to_not be_new_record
        expect(player.raw_authorization).to eq(player1)
      end
      it "registers player2 with their facebook data" do
        player = Authentication::Facebook.new(player2).authenticate

        expect(player).to be_valid
        expect(player).to_not be_new_record
        expect(player.raw_authorization).to eq(player2)
      end
    end
    context "player has an existing account" do
      it "attaches the information from facebook to the existing account" do
        initial_record = FactoryGirl.create(:player, email: "nick.desteffen@gmail.com", login_count: 2)

        player = Authentication::Facebook.new(Fixtures::Facebook.me).authenticate
        initial_record.reload

        expect(initial_record).to eq(player)
        expect(initial_record.provider).to_not be_nil
        expect(initial_record.uid).to_not be_nil
      end
    end
  end

  describe "authenticate" do
    it "should login the user through their facebook authentication" do
      player = FactoryGirl.create(:facebook_player, email: "nick.desteffen@gmail.com", login_count: 4, uid: me["uid"])

      authorized_player = Authentication::Facebook.new(me).authenticate
      player.reload

      expect(player).to eq(authorized_player)
      expect(player.login_count).to eq(5)
    end
  end

end
