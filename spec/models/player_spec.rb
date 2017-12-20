require 'rails_helper'

describe Player do

  describe "registration" do
    it "should require a password if the player is not registering through Facebook" do
      player = FactoryGirl.build(:player, email: Faker::Internet.free_email, handle: Faker::Name.first_name, password: nil, password_confirmation: nil)

      expect(player).to_not be_valid
      expect(player.errors[:password_digest]).to_not be_nil
    end
  end

  describe "profile_image_path" do
    it "should return the image from facebook if the image source is facebook" do
      player = create(:player, image_source: Player::ImageSource::Facebook, facebook_image_url: "http://graph.facebook.com/753509648/picture?type=square")

      expect(player.profile_image_path).to eq("https://graph.facebook.com/753509648/picture?type=square?type=normal")
    end
    it "should return the image from gravatar if the image source is gravatar" do
      player = create(:player, image_source: Player::ImageSource::Gravatar)

      expect(player.profile_image_path).to eq("https://www.gravatar.com/avatar/#{player.gravatar_hash}?size=100&default=https%3A%2F%2Frisk2210.net%2Fassets%2Fdefault_avatar.png")
    end
    it "should return the default image if no image source is specified" do
      player = create(:player, image_source: nil)

      expect(player.profile_image_path).to eq("https://risk2210.net/assets/default_avatar.png")
    end
  end

  describe "change_password" do

    let(:player) { create(:player, password: "secret1", password_confirmation: "secret1")}

    it "should add an error if the old password doesn't match" do
      success = player.change_password(old_password: "abc123", password: "abc123", password_confirmation: "abc123")

      expect(success).to be_falsey
      expect(player.errors[:base]).to include("Old password doesn't match")
    end
    it "should update the password if the old password matches and the new password matches the confirmation" do
      success = player.change_password(old_password: "secret1", password: "abc123", password_confirmation: "abc123")

      expect(success).to be_truthy
    end
    it "should add a confirmation error if the new password doesn't match the confirmation" do
      success = player.change_password(old_password: "secret1", password: "abc123", password_confirmation: "abc321")

      expect(success).to be_falsey
      expect(player.errors[:password]).to_not be_nil
    end
    it "should not allow the setting of a blank password" do
      success = player.change_password(old_password: "secret1", password: "", password_confirmation: "")

      expect(success).to be_falsey
      expect(player.errors[:password]).to_not be_nil
    end
  end

  describe "location" do
    it "format the city, state, and zip code" do
      player = FactoryGirl.build(:player, city: "Chicago", state: "IL", zip_code: "60640")

      expect(player.location).to eq("Chicago, IL 60640")
    end
  end

  describe "password=" do
    it "should encrypt the password and set the password_digest field" do
      player = FactoryGirl.build(:player, password: nil)

      player.password = "secret1"

      expect(player.password_digest).to_not be_nil
    end
  end

  describe "set_login_stats" do
    it "should increment the login_count and set the last_login_at to now" do
      now = Time.mktime(2012, 10, 22, 14, 30)
      allow(Time).to receive(:now).and_return(now)
      player = create(:player, login_count: 10, last_login_at: 10.days.ago)

      player.set_login_stats

      expect(player.login_count).to eq(11)
      expect(player.last_login_at).to eq(now)
    end
  end

  describe "generate_gravatar_hash" do
    it "should generate the hash if the email is present" do
      player = create(:player, gravatar_hash: nil)

      expect(player.gravatar_hash).to_not be_nil
    end
  end

  describe "deliver_welcome_email" do
    before { ActionMailer::Base.deliveries.clear }
    it "should send an email upon account creation" do
      player = create(:player)

      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end

  describe "valid_password?" do
    it "should return true if the unencrypted_password matches the player's password" do
      player = FactoryGirl.build(:player, password: "password", password_confirmation: "password")

      expect(player.valid_password?("password")).to be_truthy
      expect(player.valid_password?("password1")).to be_falsey
    end
  end

  describe "link_game_players" do
    it "should link to any game_player records that have the same handle on create" do
      game_player = create(:game_player, handle: "Jack", player: nil)

      player = create(:player, handle: "Jack")
      expect(game_player.reload.player).to eq(player)
    end
  end

  describe "request_password_reset!" do
    it "should update the password reset token and send an email with instructions" do
      player = create(:player, password_reset_token: nil)
      ActionMailer::Base.deliveries.clear

      player.request_password_reset!

      expect(player.password_reset_token).to_not be_nil
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end

  describe "name" do
    it "should concatenate first and last names" do
      player = FactoryGirl.build(:player, first_name: "Jack", last_name: "Sparrow")

      expect(player.name).to eq("Jack Sparrow")
    end
    it "should return the slug if first and last name are both blank" do
      player = FactoryGirl.build(:player, first_name: "", last_name: "")

      expect(player.name).to eq(player.slug)
    end
  end

  describe "nearby" do
    it 'returns nearby players' do
      player = create(:player, city: "Chicago", state: "IL", zip_code: "60640")
      nearby_player = create(:player, city: "Chicago", state: "IL", zip_code: "60640")

      results = Player.nearby(player.coordinates)
      expect(results.count).to eq(2)
      expect(results).to include(player)
      expect(results).to include(nearby_player)
    end
  end

end
