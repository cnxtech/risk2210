describe Array do

  describe "except" do
    it "should return the array except the value" do
      array = [1,2,3,4,5,6]

      results = array.except(3)

      expect(results).to eq [1,2,4,5,6]
    end
  end

end
