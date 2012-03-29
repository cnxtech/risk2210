class CommentsController < ApplicationController

  active_tab :forums
  
  before_filter :find_forum
  before_filter :find_topic
  before_filter :login_required

  def create
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
      @comments = @topic.comments.all
      flash.now.alert = "You can't post blank comments!"
      render template: "topics/show"
    end
  end

  private
  
  def find_forum
    @forum = Forum.find_by_slug(params[:forum_id])
  end
  
  def find_topic
    @topic = Topic.find_by_slug(params[:topic_id])
  end

end
