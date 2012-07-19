require 'spec_helper'

describe Player do
  
  describe "create_with_omniauth" do
    context "fixture users don't exist" do
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
    context "fixture users do exist" do
      it "attaches my facebook info to my existing account" do
        initial_record = FactoryGirl.create(:player, email: "nick.desteffen@gmail.com", login_count: 2)

        player = Player.create_with_omniauth(Fixtures::Facebook.me)

        initial_record.should == player
      end
    end
  end

  describe "authenticate" do
    before do
      Time.stub(:now).and_return(Time.mktime(2012, 7, 18, 14, 05))
      @player = FactoryGirl.create(:player, password: "secret1", password_confirmation: "secret1", login_count: 4, last_login_at: 1.week.ago)
    end
    it "returns the player if the authentication succeeds" do
      @player.authenticate("secret1").should == true
      @player.login_count.should == 5
      @player.last_login_at.should_not == 1.week.ago
    end
    it "returns false if the authentication fails" do
      @player.authenticate("secret2").should == false
      @player.login_count.should == 4
      @player.last_login_at.should == 1.week.ago      
    end
  end

  describe "omniauthorize" do
    it "should login the user through their facebook authorization" do
      fixture = Fixtures::Facebook.me
      player = FactoryGirl.create(:player, email: "nick.desteffen@gmail.com", login_count: 4)
      player.update_attribute(:uid, fixture["uid"])
      
      authorized_player = Player.omniauthorize(fixture)
      player.reload
      
      player.should == authorized_player
      player.login_count.should == 5
    end
  end

end

