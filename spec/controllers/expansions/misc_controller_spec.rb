require 'rails_helper'

describe Expansions::MiscController do

  describe "amoebas" do
    it "should render" do
      get :amoebas

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "galactic" do
    it "should render" do
      get :galactic

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

  describe "capitals" do
    it "should render" do
      get :capitals

      expect(assigns(:page_title)).to_not be_nil
      expect(response).to be_success
    end
  end

end
