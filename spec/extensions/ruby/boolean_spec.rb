describe TrueClass do
  describe "yes_or_no" do
    it "should return Yes" do
      expect(true.yes_or_no).to eq("Yes")
    end
  end
end

describe FalseClass do
  describe "yes_or_no" do
    it "should return No" do
      expect(false.yes_or_no).to eq("No")
    end
  end
end
