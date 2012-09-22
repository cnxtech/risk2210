require 'spec_helper'

describe PagesController do

  describe "home" do
    it "should render" do
      get :home

      response.should be_success
    end
  end

  describe "resources" do
    it "should render" do
      get :resources

      controller.active_tab.should == :resources
      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "about" do
    it "should render" do
      get :about

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "api_docs" do
    it "should render" do
      load_factions
      FactoryGirl.create(:player)
      
      get :api_docs

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

end
