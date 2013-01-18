require 'spec_helper'

describe Authentication::Risk2210 do
  include ActiveModel::Lint::Tests
  include Test::Unit::Assertions

  def model
    Authentication::Risk2210.new
  end

  describe "ActiveModel::Lint::Tests" do
    it "should be an ActiveModel compliant object" do
      test_to_key
      test_to_param
      test_to_partial_path
      test_persisted?
      test_model_naming
      test_errors_aref
    end
  end

  describe "authenticate" do
    it "should return nil if the session isn't valid" do
      session = Authentication::Risk2210.new(password: nil, email: nil)

      session.authenticate.should == nil
    end
    it "should return nil if the player hasn't been found" do
      session = Authentication::Risk2210.new(password: "secret1", email: "player@gmail.com")

      session.authenticate.should == nil
    end
    it "should return nil if the player doesn't have the correct password" do
      Time.stub(:now).and_return(Time.mktime(2012, 7, 18, 14, 05))
      player = FactoryGirl.create(:player, password: "secret1", login_count: 4, last_login_at: 1.week.ago)
      session = Authentication::Risk2210.new(password: "secret2", email: player.email)

      session.authenticate.should == nil
      player.reload
      player.login_count.should == 4
      player.last_login_at.should == 1.week.ago
    end
    it "should return the player if the player has the correct password" do
      Time.stub(:now).and_return(Time.mktime(2012, 7, 18, 14, 05))
      player = FactoryGirl.create(:player, password: "secret1", login_count: 4, last_login_at: 1.week.ago)
      session = Authentication::Risk2210.new(password: "secret1", email: player.email)

      session.authenticate.should == player
      player.reload
      player.login_count.should == 5
      player.last_login_at.should_not == 1.week.ago
    end
  end

end
