require 'spec_helper'

describe Expansions::FactionsController do

  describe "index" do
    context "html" do
      it "should have a listing of all non-default factions" do
        get :index

        expect(assigns(:factions).size).to eq(Faction.non_default.count)
        expect(assigns(:page_title)).to_not be_nil
        expect(response).to be_success
      end
    end
    context "json" do
      it "should return all non-default factions as json" do
        get :index, format: :json

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_success
        expect(json.size).to eq(Faction.non_default.count)
      end
    end
  end

  describe "show" do
    context "html" do
      it "should have the faction" do
        random_faction = Faction.random
        get :show, id: random_faction

        expect(assigns(:faction)).to eq(random_faction)
        expect(assigns(:page_title)).to include(random_faction.name)
        expect(response).to be_success
      end
    end
    context "json" do
      it "should return the faction as json" do
        random_faction = Faction.random
        get :show, id: random_faction, format: :json

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_success
        expect(json[:slug]).to eq(random_faction.slug)
      end
    end
    context "not found" do
      it "should return a 404" do
        get :show, id: "foo"

        expect(response.status).to eq(404)
      end
    end
  end

end
