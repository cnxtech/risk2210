require 'rails_helper'

describe Authentication::Risk2210 do

  # def model
  #   Authentication::Risk2210.new
  # end

  # describe "ActiveModel::Lint::Tests" do
  #   it "should be an ActiveModel compliant object" do
  #     test_errors_aref
  #     test_model_naming
  #     test_persisted?
  #     test_to_key
  #     test_to_param
  #     test_to_partial_path
  #   end
  # end

  describe "authenticate" do
    it "should return nil if the session isn't valid" do
      session = Authentication::Risk2210.new(password: nil, email: nil)

      expect(session.authenticate).to be_nil
    end
    it "should return nil if the player hasn't been found" do
      session = Authentication::Risk2210.new(password: "secret1", email: "player@gmail.com")

      expect(session.authenticate).to be_nil
    end
    it "should return nil if the player doesn't have the correct password" do
      allow(Time).to receive(:now).and_return(Time.mktime(2012, 7, 18, 14, 05))
      player = create(:player, password: "secret1", login_count: 4, last_login_at: 1.week.ago)
      session = Authentication::Risk2210.new(password: "secret2", email: player.email)

      expect(session.authenticate).to be_nil

      player.reload

      expect(player.login_count).to eq(4)
      expect(player.last_login_at).to eq(1.week.ago)
    end
    it "should return the player if the player has the correct password" do
      allow(Time).to receive(:now).and_return(Time.mktime(2012, 7, 18, 14, 05))
      player = create(:player, password: "secret1", login_count: 4, last_login_at: 1.week.ago)
      session = Authentication::Risk2210.new(password: "secret1", email: player.email)

      expect(session.authenticate).to eq(player)
      player.reload
      expect(player.login_count).to eq(5)
      expect(player.last_login_at).to_not eq(1.week.ago)
    end
    it "should set the remember me token on the player" do
      create(:player, remember_me_token: nil, password: "secret1", email: "nick.desteffen@gmail.com")

      allow(SecureRandom).to receive(:hex).with(8).and_return("28eae6141a407dfd")
      player = Authentication::Risk2210.new(password: "secret1", email: "nick.desteffen@gmail.com").authenticate

      expect(player.remember_me_token).to_not be_nil
    end
  end

end
