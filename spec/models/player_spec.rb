require 'spec_helper'

describe Player do

  describe "registration" do
    it "should require a password if the player is not registering through Facebook" do
      player = Player.new(email: Faker::Internet.free_email, handle: Faker::Name.first_name)

      player.valid?.should == false
      player.errors[:password_digest].should_not be_nil
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

  describe "profile_image_path" do
    it "should return the image from facebook if the image source is facebook" do
      player = FactoryGirl.create(:player, image_source: Player::ImageSource::Facebook, facebook_image_url: "http://graph.facebook.com/753509648/picture?type=square")

      player.profile_image_path.should == "http://graph.facebook.com/753509648/picture?type=square?type=normal"
    end
    it "should return the image from gravatar if the image source is gravatar" do
      player = FactoryGirl.create(:player, image_source: Player::ImageSource::Gravatar)

      player.profile_image_path.should == "http://www.gravatar.com/avatar/#{player.gravatar_hash}?size=100&default=http%3A%2F%2Frisk2210.net%2Fassets%2Fdefault_avatar.png"
    end
    it "should return the default image if no image source is specified" do
      player = FactoryGirl.create(:player, image_source: nil)

      player.profile_image_path.should == "http://risk2210.net/assets/default_avatar.png"
    end
  end

  describe "change_password" do

    let(:player) { FactoryGirl.create(:player, password: "secret1", password_confirmation: "secret1")}

    it "should add an error if the old password doesn't match" do
      success = player.change_password(old_password: "abc123", password: "abc123", password_confirmation: "abc123")

      success.should == false
      player.errors[:base].include?("Old password doesn't match").should == true
    end
    it "should update the password if the old password matches and the new password matches the confirmation" do
      success = player.change_password(old_password: "secret1", password: "abc123", password_confirmation: "abc123")

      success.should == true
    end
    it "should add a confirmation error if the new password doesn't match the confirmation" do
      success = player.change_password(old_password: "secret1", password: "abc123", password_confirmation: "abc321")

      success.should == false
      player.errors[:password].should_not be_nil
    end
  end

  describe "location" do
    it "format the city, state, and zip code" do
      player = FactoryGirl.create(:player, city: "Chicago", state: "IL", zip_code: "60640")

      player.location.should == "Chicago, IL 60640"
    end
  end

  describe "password=" do
    it "should encrypt the password and set the password_digest field" do
      player = FactoryGirl.build(:player, password: nil)

      player.password = "secret1"

      player.password_digest.should_not be_nil
    end
  end

  describe "authenticate" do
    context "correct password" do
      it "should return true, set login stats, set remember_me token and save" do
        Time.stub(:now).and_return(Time.mktime(2012, 10, 22, 14, 30))
        player = FactoryGirl.create(:player, password: "secret1", login_count: 10, last_login_at: 10.days.ago)

        player.authenticate("secret1").should == true

        player.login_count.should == 11
        player.last_login_at.to_s.should == "2012-10-22T19:30:00+00:00"
      end
    end
    context "wrong password" do
      it "should return false" do
        player = FactoryGirl.create(:player, password: "secret1")

        player.authenticate("abc12").should == false
      end
    end
  end

  describe "set_login_stats" do
    it "should increment the login_count and set the last_login_at to now" do
      Time.stub(:now).and_return(Time.mktime(2012, 10, 22, 14, 30))
      player = FactoryGirl.create(:player, login_count: 10, last_login_at: 10.days.ago)

      player.set_login_stats

      player.login_count.should == 11
      player.last_login_at.to_s.should == "2012-10-22T19:30:00+00:00"
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
    it "should set the remember me token on the player" do
      player = FactoryGirl.build(:player, remember_me_token: nil)

      SecureRandom.should_receive(:hex).with(8).and_return("28eae6141a407dfd")
      player.send(:set_remember_me_token)

      player.remember_me_token.should_not be_nil
    end
  end

  describe "deliver_welcome_email" do
    it "should send an email upon account creation" do
      ActionMailer::Base.deliveries.clear
      player = FactoryGirl.build(:player)

      player.save

      ActionMailer::Base.deliveries.size.should == 1
    end
  end

  describe "valid_password?" do
    it "should return true if the unencrypted_password matches the player's password" do
      player = FactoryGirl.build(:player, password: "password", password_confirmation: "password")

      player.send(:valid_password?, "password").should == true
      player.send(:valid_password?, "password1").should == false
    end
  end

  describe "link_game_players" do
    it "should link to any game_player records that have the same handle on create" do
      game_player = FactoryGirl.create(:game_player, handle: "Jack", player: nil)

      player = FactoryGirl.create(:player, handle: "Jack")

      game_player.reload.player.should == player
    end
  end

end

