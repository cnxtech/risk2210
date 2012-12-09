require 'spec_helper'

describe States do

  describe "decode" do
    it "should return the abbreviated name for the state passed in" do
      States.decode(" Wisconsin ").should == "WI"
    end
    it "should return nil if a state isn't found" do
      States.decode(" Foo ").should == nil
    end
  end

end
