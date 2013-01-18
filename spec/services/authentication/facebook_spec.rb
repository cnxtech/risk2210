require 'spec_helper'

describe Authentication::Facebook do

  describe "registering using Facebook" do
    context "player doesn't already have an account" do
      it "registers me with my Facebook omniath hash" do
        player = Authentication::Facebook.new(Fixtures::Facebook.me).authenticate

        player.valid?.should == true
        player.new_record?.should == false
        player.raw_authorization.should == Fixtures::Facebook.me
      end
      it "registers player1 with their facebook data" do
        player = Authentication::Facebook.new(Fixtures::Facebook.player1).authenticate

        player.valid?.should == true
        player.new_record?.should == false
        player.raw_authorization.should == Fixtures::Facebook.player1
      end
      it "registers player2 with their facebook data" do
        player = Authentication::Facebook.new(Fixtures::Facebook.player2).authenticate

        player.valid?.should == true
        player.new_record?.should == false
        player.raw_authorization.should == Fixtures::Facebook.player2
      end
    end
    context "player has an existing account" do
      it "attaches the information from facebook to the existing account" do
        initial_record = FactoryGirl.create(:player, email: "nick.desteffen@gmail.com", login_count: 2)

        player = Authentication::Facebook.new(Fixtures::Facebook.me).authenticate
        initial_record.reload

        initial_record.should == player
        initial_record.provider.should_not be_nil
        initial_record.uid.should_not be_nil
      end
    end
  end

  describe "authenticate" do
    it "should login the user through their facebook authentication" do
      fixture = Fixtures::Facebook.me
      player = FactoryGirl.create(:facebook_player, email: "nick.desteffen@gmail.com", login_count: 4, uid: fixture["uid"])

      authorized_player = Authentication::Facebook.new(fixture).authenticate
      player.reload

      player.should == authorized_player
      player.login_count.should == 5
    end
  end

end
