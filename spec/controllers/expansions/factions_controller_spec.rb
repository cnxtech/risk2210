require 'rails_helper'

describe Expansions::FactionsController do

  describe "index" do
    context "html" do
      it "should have a listing of all non-default factions" do
        get :index

        expect(assigns(:factions).size).to eq(Faction.non_default.count)
        expect(response).to be_success
      end
    end
  end

  describe "show" do
    context "html" do
      it "should have the faction" do
        random_faction = Faction.random
        get :show, id: random_faction

        expect(assigns(:faction)).to eq(random_faction)
        expect(response).to be_success
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
