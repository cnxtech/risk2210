require 'spec_helper'

describe Message do

  describe "notify_recipient" do
    it "should send an email to the recipient after the message has been created" do
      sender = FactoryGirl.create(:player)
      recipient = FactoryGirl.create(:player)
      ActionMailer::Base.deliveries.clear

      message = FactoryGirl.create(:message, sender: sender, recipient: recipient)

      ActionMailer::Base.deliveries.size.should == 1
    end
  end

end
