require 'rails_helper'

describe Topic do

  subject(:topic) { FactoryGirl.create(:topic, view_count: 10) }

  describe "increment_view_counter" do
    it "should increment the view count of the topic" do
      topic.increment_view_counter

      expect(topic.view_count).to eq(11)
    end
  end

end
