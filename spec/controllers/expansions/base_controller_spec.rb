require 'spec_helper'

describe Expansions::BaseController do

  describe "index" do
    it "should render" do
      get :index

      expect(response).to be_success
    end
  end

end
