class TopicsController < ApplicationController  
  
  before_filter :find_forum
  before_filter :find_topic, only: [:show, :create_comment]
  before_filter :login_required, only: [:create, :create_comment]
  
  def show
    @topic.increment_view_counter
    @comments = @topic.comments
    @comment = Comment.new
  end
  
  def create
    @topic = @forum.topics.build(params[:topic])
    @topic.player = current_player
    @topic.comments.first.player = current_player

    if @topic.save
      redirect_to forum_topic_path(@forum, @topic), notice: "Thanks for posting!"
    else
      flash.now.alert = "There was an creating your topic."
      render template: "forums/show"
    end
  end
  
  def create_comment
    if params[:comment_parent_id].present?
      parent_comment = Comment.find(params[:comment_parent_id])
      @comment = parent_comment.comments.build(params[:comment])
    else
      @comment = @topic.comments.build(params[:comment])
    end
    
    @comment.player = current_player
    if @comment.save
      redirect_to forum_topic_path(@forum, @topic), notice: "Thanks for posting!"
    else
      render action: :show
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
