class TopicsController < ApplicationController

  active_tab :forums
  
  before_filter :find_forum
  before_filter :find_topic, only: [:show]
  before_filter :login_required, only: [:create]
  
  def show
    @topic.increment_view_counter
    @comments = @topic.comments
  end
  
  def create
    @topic = @forum.topics.build(params[:topic])
    @topic.player = current_player
    @topic.comments.first.player = current_player

    if @topic.save
      redirect_to forum_topic_path(@forum, @topic), notice: "Thanks for posting!"
    else
      @topics = @forum.topics.all
      flash.now.alert = "There was an creating your topic."
      render template: "forums/show"
    end
  end
    
  private
  
  def find_forum
    @forum = Forum.find_by_slug(params[:forum_id])
  end
  
  def find_topic
    @topic = Topic.find_by_slug(params[:id])
  end
  
end
