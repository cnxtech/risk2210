require 'rails_helper'

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
      expect(response).to be_success
    end
  end

  describe "about" do
    it "should render" do
      get :about

      expect(response).to be_success
    end
  end

end
