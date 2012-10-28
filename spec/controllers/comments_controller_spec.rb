require 'spec_helper'

describe CommentsController do

  let(:player) { FactoryGirl.create(:player) }
  let(:forum) { FactoryGirl.create(:forum) }
  let(:topic) { FactoryGirl.create(:topic, forum: forum) }

  describe "create" do
    it "should require a player be logged in" do
      post :create, forum_id: forum.slug, topic_id: topic.slug, comment: {body: "This is a great game!"}

      response.should redirect_to login_path
      flash.now[:alert].should_not be_nil
    end
    it "should create the comment if everything is valid" do
      login player
    end
    it "should reload the topics/show page if there were any errors" do
      pending
    end
  end

  describe "edit" do
    it "should have the comment to edit" do
      pending
    end
    it "should not allow a comment to be edited by player other than the player that created it" do
      pending
    end
  end

  describe "update" do
    it "should update the comment if everything is valid" do
      pending
    end
    it "should reload the topics/show page if the player tries to change the comment's body to be blank" do
      pending
    end
  end

end
