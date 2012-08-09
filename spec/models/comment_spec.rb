require 'spec_helper'

describe Comment do

  describe "update_topic_stats" do
    it "update the stats on the topic after the comment has been created" do
      topic = FactoryGirl.create(:topic, comment_count: 10, last_comment_at: 1.week.ago)

      comment = FactoryGirl.create(:topic_comment, commentable: topic)

      topic.comment_count.should eq(11)
      topic.last_comment_at.should === DateTime.now
    end
  end

  describe "decrement_comment_counter" do
    it "decrement the comment counter when a comment is destroyed" do
      topic = FactoryGirl.create(:topic, comment_count: 10, last_comment_at: 1.week.ago)
      comment = FactoryGirl.create(:topic_comment, commentable: topic)

      topic.comment_count.should eq(11)
      comment.destroy
      topic.comment_count.should eq(10)
    end
  end

  describe "topic" do
    it "should return the parent topic" do
      topic = FactoryGirl.create(:topic)
      comment = FactoryGirl.create(:topic_comment, commentable: topic)

      comment.topic.should == topic
    end
    it "should return the commentable's topic if it is a comment" do
      topic = FactoryGirl.create(:topic)
      comment = FactoryGirl.create(:topic_comment, commentable: topic)
      second_comment = FactoryGirl.create(:comment_comment, commentable: comment, topic_id: topic.id)

      second_comment.topic.should == topic      
    end
  end

end
