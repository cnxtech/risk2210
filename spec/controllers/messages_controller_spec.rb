require 'spec_helper'

describe MessagesController do

  let(:player) { FactoryGirl.create(:player) }
  let(:other_player) { FactoryGirl.create(:player) }

  before { login(player) }

  describe "index" do
    let!(:sent_message) { FactoryGirl.create(:message, sender: player, recipient: other_player) }
    let!(:received_message) { FactoryGirl.create(:message, sender: other_player, recipient: player) }
    context "sent filter" do
      it "should list all messages sent" do
        get :index, filter: "sent"

        assigns(:messages).include?(received_message).should == false
        assigns(:messages).include?(sent_message).should == true
        response.should be_success
      end
    end
    context "no filter" do
      it "should list all messages received" do
        get :index

        assigns(:messages).include?(received_message).should == true
        assigns(:messages).include?(sent_message).should == false
        response.should be_success
      end
    end
  end

  describe "new" do
    context "recipient parameter is present" do
      it "should have a message object setup with the recipient" do
        recipient = FactoryGirl.create(:player)

        get :new, recipient: other_player.slug

        assigns(:message).recipient.should == other_player
      end
    end
    context "no recipient present" do
      it "should have a blank message object" do
        get :new

        assigns(:message).should_not be_nil
      end
    end
  end

  describe "create" do
    context "success" do
      it "should create the message" do
        expect{
          post :create, message: {recipient_id: other_player.id, body: Faker::Lorem.sentences.join(". "), subject: Faker::Lorem::sentence}
        }.to change(Message, :count).by(1)

        response.should redirect_to messages_path
        flash.notice.should_not be_nil
      end
    end
    context "failure" do
      it "should reload the page" do
        post :create, message: {recipient_id: other_player.id, body: "", subject: ""}

        response.should render_template(:new)
        flash.now[:alert].should_not be_nil
      end
    end
  end

end
