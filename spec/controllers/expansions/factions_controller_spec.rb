require 'spec_helper'

describe Expansions::FactionsController do

  before do
    Rails.application.load_seed
  end

  describe "index" do
    context "html" do
      it "should have a listing of all non-default factions" do
        get :index

        assigns(:factions).size.should == Faction.non_default.count
        assigns(:page_title).should_not be_nil
        response.should be_success
      end
    end
    context "json" do
      it "should return all non-default factions as json" do
        get :index, format: :json

        response.should be_success
        json = JSON.parse(response.body, symbolize_names: true)
        json.size.should == Faction.non_default.count
      end
    end
  end

  describe "show" do
    context "html" do
      it "should have the faction" do
        random_faction = Faction.all.sample
        get :show, id: random_faction

        assigns(:faction).should == random_faction
        assigns(:page_title).include?(random_faction.name).should == true
        response.should be_success
      end
    end
    context "json" do
      it "should return the faction as json" do
        random_faction = Faction.all.sample
        get :show, id: random_faction, format: :json

        response.should be_success
        json = JSON.parse(response.body, symbolize_names: true)
        json[:slug].should == random_faction.slug
      end
    end
  end

end
