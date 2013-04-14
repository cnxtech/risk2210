require 'spec_helper'

describe Expansions::BaseController do

  describe "index" do
    it "should render" do
      get :index

      response.should be_success
    end
  end

end
