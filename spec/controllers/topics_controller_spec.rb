require 'spec_helper'

describe TopicsController do

  let(:player) { FactoryGirl.create(:player) }
  let(:forum) { FactoryGirl.create(:forum) }
  let(:topic) { FactoryGirl.create(:topic, forum: forum, view_count: 10) }
  let!(:comment) { FactoryGirl.create(:topic_comment, commentable: topic) }

  describe "show" do
    it "should dislay a forum topic, all comments, and increment the topic view counter" do
      get :show, forum_id: forum, id: topic.slug

      expect(response).to be_success
      expect(session[:topics_viewed]).to include(topic.id)
      expect(topic.reload.view_count).to eq(11)
      expect(assigns(:comments)).to_not be_nil
    end
    it "should not increment the topic view counter if the topic has already been viewed in the current session" do
      session[:topics_viewed] = [topic.id]

      get :show, forum_id: forum, id: topic.slug

      expect(response).to be_success
      expect(topic.reload.view_count).to eq(10)
    end
  end

  describe "create" do
    it "requires a player be logged in" do
      post :create, forum_id: forum, topic: {subject: "Risk is awesome!", comments_attributes: {"0" => {body: "It rules because x, y, z."}}}

      expect(response).to redirect_to login_path
      expect(flash[:alert]).to_not be_nil
    end
    it "should create a forum topic with a comment if everything is valid" do
      login player

      expect{
        post :create, forum_id: forum, topic: {subject: "Risk is awesome!", comments_attributes: {"0" => {body: "It rules because x, y, z."}}}
      }.to change(Topic, :count).by(1)

      topic = assigns(:topic)
      expect(response).to redirect_to forum_topic_path(forum.slug, topic.slug)
      expect(topic.player).to eq(player)
      expect(topic.comments.first.player).to eq(player)
      expect(session[:topics_viewed]).to include(topic.id)
      expect(flash[:notice]).to_not be_nil
    end
    it "should reload the page if there were any errors" do
      login player

      post :create, forum_id: forum, topic: {subject: "", comments_attributes: {"0" => {body: "It rules because x, y, z."}}}

      expect(response).to render_template("forums/show")
      expect(flash.now[:alert]).to_not be_nil
      expect(assigns(:topics)).to_not be_nil
    end
  end

end
