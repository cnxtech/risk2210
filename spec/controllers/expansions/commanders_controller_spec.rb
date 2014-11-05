require 'rails_helper'

describe Expansions::CommandersController do

  describe "tech" do
    it "should render" do
      get :tech

      expect(response).to be_success
    end
  end

  describe "resistance" do
    it "should render" do
      get :resistance

      expect(response).to be_success
    end
  end

  describe "majors_promo_cards" do
    it "should render" do
      get :majors_promo_cards

      expect(response).to be_success
    end
  end

  describe "galaxy" do
    it "should render" do
      get :galaxy

      expect(response).to be_success
    end
  end

end
