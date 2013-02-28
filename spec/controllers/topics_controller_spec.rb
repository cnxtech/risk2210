require 'spec_helper'

describe TopicsController do

  let(:player) { FactoryGirl.create(:player) }
  let(:forum) { FactoryGirl.create(:forum) }

  describe "show" do
    before do
      @topic = FactoryGirl.create(:topic, forum: forum, view_count: 10)
      @comment = FactoryGirl.create(:topic_comment, commentable: @topic)
    end
    it "should dislay a forum topic, all comments, and increment the topic view counter" do
      get :show, forum_id: forum, id: @topic.slug

      response.should be_success
      session[:topics_viewed].include?(@topic.id).should == true
      @topic.reload.view_count.should == 11
      assigns(:comments).should_not be_nil
    end
    it "should not increment the topic view counter if the topic has already been viewed in the current session" do
      session[:topics_viewed] = [@topic.id]

      get :show, forum_id: forum, id: @topic.slug

      response.should be_success
      @topic.reload.view_count.should == 10
    end
  end

  describe "create" do
    it "requires a player be logged in" do
      post :create, forum_id: forum, topic: {subject: "Risk is awesome!", comments_attributes: {"0" => {body: "It rules because x, y, z."}}}

      response.should redirect_to login_path
      flash[:alert].should_not be_nil
    end
    it "should create a forum topic with a comment if everything is valid" do
      login player

      expect{
        post :create, forum_id: forum, topic: {subject: "Risk is awesome!", comments_attributes: {"0" => {body: "It rules because x, y, z."}}}
      }.to change(Topic, :count).by(1)

      topic = assigns(:topic)
      response.should redirect_to forum_topic_path(forum.slug, topic.slug)
      topic.player.should == player
      topic.comments.first.player.should == player
      session[:topics_viewed].include?(topic.id).should == true
      flash[:notice].should_not be_nil
    end
    it "should reload the page if there were any errors" do
      login player

      post :create, forum_id: forum, topic: {subject: "", comments_attributes: {"0" => {body: "It rules because x, y, z."}}}

      response.should render_template("forums/show")
      flash.now[:alert].should_not be_nil
      assigns(:topics).should_not be_nil
    end
  end

end
