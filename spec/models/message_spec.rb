require 'spec_helper'

describe Message do

  let!(:sender) { FactoryGirl.create(:player) }
  let!(:recipient) { FactoryGirl.create(:player) }

  before { ActionMailer::Base.deliveries.clear }

  describe "notify_recipient" do
    it "should send an email to the recipient after the message has been created" do
      message = FactoryGirl.create(:message, sender: sender, recipient: recipient)

      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end

end
