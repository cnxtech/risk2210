require 'spec_helper'

describe ForumsController do

  describe "index" do
    it "should list all forums" do
      FactoryGirl.create(:forum)
      FactoryGirl.create(:forum)

      get :index

      assigns(:forums).size.should == 2
      assigns(:page_title).should_not be_nil
      response.should be_success
    end
  end

  describe "show" do
    it "should have a forum" do
      forum = FactoryGirl.create(:forum)
      topic = FactoryGirl.create(:topic, forum: forum)
      comment = FactoryGirl.create(:topic_comment, commentable: topic)

      get :show, id: forum.slug

      assigns(:forum).should == forum
      assigns(:page_title).include?(forum.name).should == true
      assigns(:topics).size.should == forum.topics.size
      assigns(:topic).new_record?.should == true
      assigns(:topic).comments.size.should == 1
      response.should be_success
    end
  end

end
