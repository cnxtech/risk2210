require 'spec_helper'

describe CommentsController do

  let(:player) { FactoryGirl.create(:player) }
  let(:forum) { FactoryGirl.create(:forum) }
  let(:topic) { FactoryGirl.create(:topic, forum: forum) }
  let(:comment) { FactoryGirl.create(:topic_comment, commentable: topic, player: player) }

  describe "create" do
    context "user isn't logged in" do
      it "should require a player be logged in" do
        post :create, forum_id: forum, topic_id: topic, comment: {body: "This is a great game!"}

        expect(response).to redirect_to login_path
        expect(flash.now[:alert]).to_not be_nil
      end
    end
    context "user is logged in" do
      before { login player }
      context "parent is a topic" do
        it "should create the comment if everything is valid" do
          expect{
            post :create, forum_id: forum, topic_id: topic, comment: {body: "This is a great game!"}
          }.to change(topic.comments, :count).by(1)

          expect(response).to redirect_to(forum_topic_path(forum, topic))
          expect(flash.notice).to_not be_nil
          expect(assigns(:comment).player).to eq(player)
        end
        it "should reload the topics/show page if there were any errors" do
          expect{
            post :create, forum_id: forum, topic_id: topic, comment: {body: ""}
          }.to change(topic.comments, :count).by(0)

          expect(response).to render_template("topics/show")
          expect(flash.now[:alert]).to_not be_nil
        end
      end
      context "parent is another comment" do
        it "should create the comment if everything is valid" do
          expect{
            post :create, forum_id: forum, topic_id: topic.slug, comment_parent_id: comment.id, comment: {body: "This is a great game!"}
          }.to change(comment.comments, :count).by(1)

          expect(response).to redirect_to(forum_topic_path(forum, topic))
          expect(flash.notice).to_not be_nil
          expect(assigns(:comment).player).to eq(player)
        end
        it "should reload the topics/show page if there were any errors" do
          expect{
            post :create, forum_id: forum, topic_id: topic, comment_parent_id: comment.id, comment: {body: ""}
          }.to change(comment.comments, :count).by(0)

          expect(response).to render_template("topics/show")
          expect(flash.now[:alert]).to_not be_nil
        end
      end
    end
  end

  describe "edit" do
    before { login player }
    it "should have the comment to edit" do
      get :edit, forum_id: forum, topic_id: topic, id: comment.id

      expect(assigns(:comment)).to eq(comment)
    end
    it "should not allow a comment to be edited by player other than the player that created it" do
      different_comment = FactoryGirl.create(:topic_comment, commentable: topic)

      get :edit, forum_id: forum, topic_id: topic, id: different_comment.id

      expect(response.status).to eq(404)
    end
  end

  describe "update" do
    before { login player }
    it "should update the comment if everything is valid" do
      put :update, forum_id: forum, topic_id: topic, id: comment.id, comment: {body: "This is the new body"}

      expect(response).to redirect_to forum_topic_path(forum, topic)
      expect(flash.notice).to_not be_nil
    end
    it "should reload the topics/show page if the player tries to change the comment's body to be blank" do
      put :update, forum_id: forum, topic_id: topic, id: comment.id, comment: {body: ""}

      expect(response).to render_template(:edit)
      expect(flash.now[:alert]).to_not be_nil
    end
  end

end
