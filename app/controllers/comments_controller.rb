class CommentsController < ApplicationController

  active_tab :forums
  
  before_filter :find_forum
  before_filter :find_topic
  before_filter :add_topic_id_to_params
  before_filter :login_required

  def create
    if params[:comment_parent_id].present?
      parent = Comment.find(params[:comment_parent_id])
    else
      parent = @topic
    end
    
    @comment = parent.comments.build(params[:comment])
    @comment.player = current_player
    if @comment.save
      redirect_to forum_topic_path(@forum, @topic), notice: "Thanks for posting!"
    else
      @comments = @topic.comments.all
      flash.now.alert = "You can't post blank comments!"
      render template: "topics/show"
    end
  end

  def edit
    @comment = current_player.comments.find(params[:id])
  end

  def update
    @comment = current_player.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to forum_topic_path(@forum, @topic), notice: "Successfully updated your comment."
    else
      flash.now.alert = "You can't post blank comments!"
      render action: :edit
    end
  end

  private
  
  def find_forum
    @forum = Forum.find(params[:forum_id])
  end
  
  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  def add_topic_id_to_params
    params[:comment].merge!(topic_id: @topic.id) if params[:comment]
  end

end
