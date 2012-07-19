require 'spec_helper'

describe Player do
  
  describe "create_with_omniauth" do
    it "registers me with my Facebook omniath hash" do
      player = Player.create_with_omniauth(Fixtures::Facebook.me)

      player.valid?.should == true
      player.new_record?.should == false
      player.raw_authorization.should == Fixtures::Facebook.me
    end
    it "registers another guy with their facebook hash" do
      player = Player.create_with_omniauth(Fixtures::Facebook.dude)

      player.valid?.should == true
      player.new_record?.should == false
      player.raw_authorization.should == Fixtures::Facebook.dude
    end
  end
  
end

