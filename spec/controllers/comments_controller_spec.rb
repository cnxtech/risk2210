require 'spec_helper'

describe CommentsController do

  let(:player) { FactoryGirl.create(:player) }
  let(:forum) { FactoryGirl.create(:forum) }
  let(:topic) { FactoryGirl.create(:topic, forum: forum) }

  describe "create" do
    it "should require a player be logged in" do
      post :create, forum_id: forum, topic_id: topic, comment: {body: "This is a great game!"}

      response.should redirect_to login_path
      flash.now[:alert].should_not be_nil
    end
    context "parent is a topic" do
      it "should create the comment if everything is valid" do
        login player

        expect{
          post :create, forum_id: forum, topic_id: topic, comment: {body: "This is a great game!"}
        }.to change(topic.comments, :count).by(1)

        response.should redirect_to(forum_topic_path(forum, topic))
        flash.notice.should_not be_nil
        assigns(:comment).player.should == player
      end
      it "should reload the topics/show page if there were any errors" do
        login player

        expect{
          post :create, forum_id: forum, topic_id: topic, comment: {body: ""}
        }.to change(topic.comments, :count).by(0)

        response.should render_template("topics/show")
        flash.now[:alert].should_not be_nil
      end
    end
    context "parent is another comment" do
      before do
        login player
        @original_comment = FactoryGirl.create(:topic_comment, commentable: topic)
      end
      it "should create the comment if everything is valid" do
        expect{
          post :create, forum_id: forum, topic_id: topic, comment_parent_id: @original_comment.id, comment: {body: "This is a great game!"}
        }.to change(@original_comment.comments, :count).by(1)

        response.should redirect_to(forum_topic_path(forum, topic))
        flash.notice.should_not be_nil
        assigns(:comment).player.should == player
      end
      it "should reload the topics/show page if there were any errors" do
        expect{
          post :create, forum_id: forum, topic_id: topic, comment: {body: ""}
        }.to change(@original_comment.comments, :count).by(0)

        response.should render_template("topics/show")
        flash.now[:alert].should_not be_nil
      end
    end
  end

  describe "edit" do
    it "should have the comment to edit" do
      comment = FactoryGirl.create(:topic_comment, commentable: topic, player: player)
      login player

      get :edit, forum_id: forum, topic_id: topic, id: comment.id

      assigns(:comment).should == comment
    end
    it "should not allow a comment to be edited by player other than the player that created it" do
      comment = FactoryGirl.create(:topic_comment, commentable: topic)
      login player

      get :edit, forum_id: forum, topic_id: topic, id: comment.id

      response.status.should == 404
    end
  end

  describe "update" do
    before do
      @comment = FactoryGirl.create(:topic_comment, commentable: topic, player: player)
      login player
    end
    it "should update the comment if everything is valid" do
      put :update, forum_id: forum, topic_id: topic, id: @comment.id, comment: {body: "This is the new body"}

      response.should redirect_to forum_topic_path(forum, topic)
      flash.notice.should_not be_nil
    end
    it "should reload the topics/show page if the player tries to change the comment's body to be blank" do
      put :update, forum_id: forum, topic_id: topic, id: @comment.id, comment: {body: ""}

      response.should render_template(:edit)
      flash.now[:alert].should_not be_nil
    end
  end

end
