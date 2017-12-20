require 'rails_helper'

describe MessagesController do

  let(:player) { create(:player) }
  let(:other_player) { create(:player) }

  before { login(player) }

  describe "index" do
    let!(:sent_message) { create(:message, sender: player, recipient: other_player) }
    let!(:received_message) { create(:message, sender: other_player, recipient: player) }
    context "sent filter" do
      it "should list all messages sent" do
        get :index, filter: "sent"

        expect(assigns(:messages)).to_not include(received_message)
        expect(assigns(:messages)).to include(sent_message)
        expect(response).to be_success
      end
    end
    context "no filter" do
      it "should list all messages received" do
        get :index

        expect(assigns(:messages)).to include(received_message)
        expect(assigns(:messages)).to_not include(sent_message)
        expect(response).to be_success
      end
    end
  end

  describe "new" do
    context "recipient parameter is present" do
      it "should have a message object setup with the recipient" do
        recipient = create(:player)

        get :new, recipient: other_player.slug

        expect(assigns(:message).recipient).to eq(other_player)
      end
    end
    context "no recipient present" do
      it "should have a blank message object" do
        get :new

        expect(assigns(:message)).to_not be_nil
      end
    end
  end

  describe "create" do
    context "success" do
      it "should create the message" do
        expect{
          post :create, message: {recipient_id: other_player.id, body: Faker::Lorem.sentences.join(". "), subject: Faker::Lorem::sentence}
        }.to change(Message, :count).by(1)

        expect(response).to redirect_to messages_path
        expect(flash.notice).to_not be_nil
      end
    end
    context "failure" do
      it "should reload the page" do
        post :create, message: {recipient_id: other_player.id, body: "", subject: ""}

        expect(response).to render_template(:new)
        expect(flash.now[:alert]).to_not be_nil
      end
    end
  end

end
