require 'spec_helper'

describe String do

  describe "to_boolean" do
    it "should return true for t, 1, or true" do
      "t".to_boolean.should == true
      "1".to_boolean.should == true
      "true".to_boolean.should == true
    end
    it "should return false for f, 0, or false" do
      "f".to_boolean.should == false
      "0".to_boolean.should == false
      "false".to_boolean.should == false      
    end
  end

end