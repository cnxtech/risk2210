require 'spec_helper'

describe Expansions::MapsController do

  describe "mars" do
    it "should render" do
      get :mars

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "io" do
    it "should render" do
      get :io

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "europa" do
    it "should render" do
      get :europa

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "asteroid_colonies" do
    it "should render" do
      get :asteroid_colonies

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "pluto" do
    it "should render" do
      get :pluto

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "arctic" do
    it "should render" do
      get :arctic

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "titan" do
    it "should render" do
      get :titan

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "antarctica" do
    it "should render" do
      get :antarctica

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "dark_side_moon" do
    it "should render" do
      get :dark_side_moon

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

end
