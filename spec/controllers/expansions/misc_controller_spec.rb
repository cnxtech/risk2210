require 'spec_helper'

describe Expansions::MiscController do

  describe "amoebas" do
    it "should render" do
      get :amoebas

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "galactic" do
    it "should render" do
      get :galactic

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "capitals" do
    it "should render" do
      get :capitals

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

end
