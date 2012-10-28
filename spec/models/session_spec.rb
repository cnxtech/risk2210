require 'spec_helper'

describe Session do

  describe "authenticated?" do
    it "should return false if the session isn't valid" do
      session = Session.new(password: nil, email: nil)

      session.authenticated?.should == false
    end
    it "should return false if the player hasn't been found" do
      session = Session.new(password: "secret1", email: "player@gmail.com")

      session.authenticated?.should == false
    end
    it "should return false if the player doesn't have the correct password" do
      player = FactoryGirl.create(:player, password: "secret1")
      session = Session.new(password: "secret2", email: player.email)

      session.authenticated?.should == false
    end
    it "should return true if the player has the correct password" do
      player = FactoryGirl.create(:player, password: "secret1")
      session = Session.new(password: "secret1", email: player.email)

      session.authenticated?.should == true      
    end
  end
  
end
