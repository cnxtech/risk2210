require 'spec_helper'

describe Topic do
  
  describe "increment_view_counter" do
    it "should increment the view count of the topic" do
      topic = FactoryGirl.create(:topic, view_count: 10)    

      topic.increment_view_counter

      topic.view_count.should eq(11)
    end
  end

end
