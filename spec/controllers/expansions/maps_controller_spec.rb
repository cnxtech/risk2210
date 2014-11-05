require 'rails_helper'

describe Expansions::MapsController do

  describe "mars" do
    it "should render" do
      get :mars

      expect(response).to be_success
    end
  end

  describe "io" do
    it "should render" do
      get :io

      expect(response).to be_success
    end
  end

  describe "europa" do
    it "should render" do
      get :europa

      expect(response).to be_success
    end
  end

  describe "asteroid_colonies" do
    it "should render" do
      get :asteroid_colonies

      expect(response).to be_success
    end
  end

  describe "pluto" do
    it "should render" do
      get :pluto

      expect(response).to be_success
    end
  end

  describe "arctic" do
    it "should render" do
      get :arctic

      expect(response).to be_success
    end
  end

  describe "titan" do
    it "should render" do
      get :titan

      expect(response).to be_success
    end
  end

  describe "antarctica" do
    it "should render" do
      get :antarctica

      expect(response).to be_success
    end
  end

  describe "dark_side_moon" do
    it "should render" do
      get :dark_side_moon

      expect(response).to be_success
    end
  end

end
