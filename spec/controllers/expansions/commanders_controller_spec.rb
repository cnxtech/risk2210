require 'spec_helper'

describe Expansions::CommandersController do

  describe "tech" do
    it "should render" do
      get :tech

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "resistance" do
    it "should render" do
      get :resistance

      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

end
