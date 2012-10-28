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
      it "registers another chick with their facebook hash" do
        player = Player.create_with_omniauth(Fixtures::Facebook.chick)

        player.valid?.should == true
        player.new_record?.should == false
        player.raw_authorization.should == Fixtures::Facebook.chick        
      end
    end
    context "fixture users do exist" do
      it "attaches my facebook info to my existing account" do
        initial_record = FactoryGirl.create(:player, email: "nick.desteffen@gmail.com", login_count: 2)

        player = Player.create_with_omniauth(Fixtures::Facebook.me)
        initial_record.reload

        initial_record.should == player
        initial_record.provider.should_not be_nil
        initial_record.uid.should_not be_nil
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
      player = FactoryGirl.create(:facebook_player, email: "nick.desteffen@gmail.com", login_count: 4, uid: fixture["uid"])
      
      authorized_player = Player.omniauthorize(fixture)
      player.reload

      player.should == authorized_player
      player.login_count.should == 5
    end
  end

  describe "profile_image_path" do
    it "should description" do
      pending
    end
  end

  describe "change_password" do
    it "should description" do
      pending
    end
  end

  describe "nearby_players" do
    it "should description" do
      pending
    end
  end

  describe "location" do
    it "format the city, state, and zip code" do
      player = FactoryGirl.create(:player, city: "Chicago", state: "IL", zip_code: "60640")

      player.location.should == "Chicago, IL 60640"
    end
  end

  describe "password=" do
    it "should description" do
      pending
    end
  end

  describe "authenticate" do
    it "should description" do
      pending
    end
  end

  describe "set_login_stats" do
    it "should description" do
      pending
    end
  end

  describe "generate_gravatar_hash" do
    it "should generate the hash if the email is present" do
      player = FactoryGirl.build(:player, gravatar_hash: nil)

      player.save

      player.reload.gravatar_hash.should_not be_nil
    end
  end

  describe "set_remember_me_token" do
    it "should description" do
      pending
    end
  end

  describe "deliver_welcome_email" do
    it "should description" do
      pending
    end
  end

  describe "valid_password?" do
    it "should return true if the unencrypted_password matches the player's password" do
      player = FactoryGirl.build(:player, password: "password", password_confirmation: "password")

      player.send(:valid_password?, "password").should == true
      player.send(:valid_password?, "password1").should == false
    end
  end

end

