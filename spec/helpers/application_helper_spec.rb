require 'rails_helper'

describe ApplicationHelper do

  describe "error_messages_for" do
    it "builds out error messages with the object" do
      player = FactoryGirl.build(:player, email: nil)
      player.valid?

      error_messages = helper.error_messages_for(player)

      expect(error_messages).to match(/Email can&#39;t be blank/)
      expect(error_messages).to match(/alert-heading/)
    end
  end

  describe "flash_messages" do
    it "returns nothing if there is no flash" do
      allow(helper).to receive(:flash).and_return({})

      expect(helper.flash_messages).to be_nil
    end
    it "builds out error flash messages with a close button and error class" do
      flash_messages = {'alert' => "Something went wrong"}
      allow(helper).to receive(:flash).and_return(flash_messages)

      expect(helper.flash_messages).to match(/alert-danger/)
      expect(helper.flash_messages).to match(/Something went wrong/)
    end
    it "builds out error flash messages with a close button and error class" do
      flash_messages = {'notice' => "Something went right"}
      allow(helper).to receive(:flash).and_return(flash_messages)

      expect(helper.flash_messages).to match(/alert-success/)
      expect(helper.flash_messages).to match(/Something went right/)
    end
  end

  describe "navigation_item" do
    it "should return a formatted item for the navigation list" do
      controller = double(:controller, active_tab: :home)
      allow(helper).to receive(:controller).and_return(controller)

      expect(helper.navigation_item("Players", "/players", :players)).to eq "<li class=\"\"><a href=\"/players\">Players</a></li>"
    end
    it "should have the active class if the current controller's active_tab key matches the key on the item" do
      controller = double(:controller, active_tab: :home)
      allow(helper).to receive(:controller).and_return(controller)

      expect(helper.navigation_item("Home", "/", :home)).to eq "<li class=\"active\"><a href=\"/\">Home</a></li>"
    end
  end

  describe "format_timestamp" do
    it "should return a formatted timestamp" do
      allow(Time).to receive(:now).and_return(Time.mktime(2012, 10, 22, 14, 30))

      expect(helper.format_timestamp(Time.now)).to eq("10/22/2012 02:30pm")
    end
  end

  describe "format_date" do
    it "should return a formated date" do
      allow(Time).to receive(:now).and_return(Time.mktime(2012, 10, 22, 14, 30))

      expect(helper.format_date(Time.now)).to eq("10/22/2012")
    end
  end

  describe "page_title" do
    before do
      allow(helper).to receive(:controller).and_return(ApplicationController.new)
    end
    it "and_return the page title in @page_title" do
      view.content_for(:page_title, "Test")

      expect(helper.page_title).to eq("Test | Risk Tracker | Risk 2210 A.D.")
    end
    it "and_return the active tab value if it is present" do
      allow(helper.controller).to receive(:active_tab).and_return(:factions)

      expect(helper.page_title).to eq("Factions | Risk Tracker | Risk 2210 A.D.")
    end
  end

  describe "format_markdown" do
    it "should render markdown" do
      expect(helper.format_markdown("**Bold**")).to eq("<p><strong>Bold</strong></p>\n")
    end
  end

  describe "facebook_button" do
    it "should return a button to authenicate via Facebook" do
      expect(helper.facebook_button).to eq("<a class=\"btn btn-social btn-facebook\" href=\"/login/facebook\"><i class=\"fa fa-facebook\"></i>Login with Facebook</a>")
    end
  end

  describe "download_expansion_button" do
    it "should return a download expansion button" do
      expect(helper.download_expansion_button("/expansion.zip")).to eq("<a class=\"btn btn-danger btn-large\" href=\"/expansion.zip\"><i class=\"fa fa-arrow-down fa-lg\"></i> Download Bundled Expansion Pack</a>")
    end
  end

end
