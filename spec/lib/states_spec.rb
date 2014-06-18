describe States do

  describe "decode" do
    it "should return the abbreviated name for the state passed in" do
      expect(States.decode(" Wisconsin ")).to eq("WI")
    end
    it "should return nil if a state isn't found" do
      expect(States.decode(" Foo ")).to be_nil
    end
  end

end
