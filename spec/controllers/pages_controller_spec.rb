require 'spec_helper'

describe PagesController do

  describe "home" do
    it "should render" do
      get :home

      expect(response).to be_success
    end
  end

  describe "resources" do
    it "should render" do
      get :resources

      expect(controller.active_tab).to eq(:resources)
      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "about" do
    it "should render" do
      get :about

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "api_docs" do
    it "should render" do
      FactoryGirl.create(:player)

      get :api_docs

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

end
