require 'spec_helper'

describe ApplicationHelper do

  describe "error_messages_for" do
    it "builds out error messages with the object" do
      player = FactoryGirl.build(:player, email: nil)
      player.valid?

      error_messages = helper.error_messages_for(player)

      error_messages.should =~ /Email can&#x27;t be blank/
      error_messages.should =~ /alert-heading/
    end
  end

  describe "flash_messages" do
    it "returns nothing if there is no flash" do
      helper.stub(:flash).and_return({})

      helper.flash_messages.should == nil
    end
    it "builds out error flash messages with a close button and error class" do
      flash_messages = {alert: "Something went wrong"}
      helper.stub(:flash).and_return(flash_messages)

      helper.flash_messages.should =~ /alert-error/
      helper.flash_messages.should =~ /Something went wrong/
    end
    it "builds out error flash messages with a close button and error class" do
      flash_messages = {notice: "Something went right"}
      helper.stub(:flash).and_return(flash_messages)

      helper.flash_messages.should =~ /alert-success/
      helper.flash_messages.should =~ /Something went right/
    end
  end

  describe "navigation_item" do
    it "should return a formatted item for the navigation list" do
      controller = double(:controller, active_tab: :home)
      helper.stub(:controller).and_return(controller)

      helper.navigation_item("Players", "/players", :players).should == "<li class=\"\"><a href=\"/players\">Players</a></li>"
    end
    it "should have the active class if the current controller's active_tab key matches the key on the item" do
      controller = double(:controller, active_tab: :home)
      helper.stub(:controller).and_return(controller)

      helper.navigation_item("Home", "/", :home).should == "<li class=\"active\"><a href=\"/\">Home</a></li>"
    end
  end

  describe "format_timestamp" do
    it "should return a formatted timestamp" do
      Time.stub(:now).and_return(Time.mktime(2012, 10, 22, 14, 30))

      helper.format_timestamp(Time.now).should == "10/22/2012 02:30pm"
    end
  end

  describe "format_date" do
    it "should return a formated date" do
      Time.stub(:now).and_return(Time.mktime(2012, 10, 22, 14, 30))

      helper.format_date(Time.now).should == "10/22/2012"
    end
  end

  describe "page_title" do
    it "should return the page title with the @page_title instance variable set" do
      @page_title = "Factions"
      helper.page_title.should == "Factions | Risk Tracker | Risk 2210 A.D."
    end
    it "should just return a default title if no instance variable has been set" do
      helper.page_title.should == "Risk Tracker | Risk 2210 A.D."
    end
  end

  describe "yes_or_no" do
    it "should return yes for true" do
      helper.yes_or_no(true).should == "Yes"
    end
    it "should return no for false" do
      helper.yes_or_no(false).should == "No"
    end
  end

  describe "logged_in?" do
    it "should be true if there is a current player" do
      helper.stub(:current_player).and_return(FactoryGirl.create(:player))

      helper.logged_in?.should == true
    end
    it "should return false if there is no current user logged in" do
      helper.stub(:current_player).and_return(nil)

      helper.logged_in?.should == false
    end
  end

  describe "format_markdown" do
    it "should render markdown" do
      helper.format_markdown("**Bold**").should == "<p><strong>Bold</strong></p>\n"
    end
  end

  describe "facebook_button" do
    it "should return a button to authenicate via Facebook" do
      helper.facebook_button.should == "<a href=\"/login/facebook\" class=\"btn btn-inverse \"><i class=\"icon-facebook-sign icon-large\"></i> Login with Facebook</a>"
    end
  end

end
