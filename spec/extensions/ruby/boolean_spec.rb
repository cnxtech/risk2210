require 'spec_helper'

describe TrueClass do
  describe "yes_or_no" do
    it "should return Yes" do
      true.yes_or_no.should == "Yes"
    end
  end
end

describe FalseClass do
  describe "yes_or_no" do
    it "should return No" do
      false.yes_or_no.should == "No"
    end
  end
end
