require 'spec_helper'

describe Expansions::MapsController do

  describe "mars" do
    it "should render" do
      get :mars

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "io" do
    it "should render" do
      get :io

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "europa" do
    it "should render" do
      get :europa

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "asteroid_colonies" do
    it "should render" do
      get :asteroid_colonies

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "pluto" do
    it "should render" do
      get :pluto

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

end
