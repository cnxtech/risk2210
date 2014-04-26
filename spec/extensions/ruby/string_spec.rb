require 'spec_helper'

describe String do

  describe "to_boolean" do
    it "should return true for t, 1, or true" do
      expect("t".to_boolean).to be_truthy
      expect("1".to_boolean).to be_truthy
      expect("true".to_boolean).to be_truthy
    end
    it "should return false for f, 0, or false" do
      expect("f".to_boolean).to be_falsey
      expect("0".to_boolean).to be_falsey
      expect("false".to_boolean).to be_falsey
    end
  end

end
