require 'rails_helper'

describe Message do

  let!(:sender) { create(:player) }
  let!(:recipient) { create(:player) }

  before { ActionMailer::Base.deliveries.clear }

  describe "notify_recipient" do
    it "should send an email to the recipient after the message has been created" do
      message = create(:message, sender: sender, recipient: recipient)

      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end

end
