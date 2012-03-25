class ForumsController < ApplicationController

  active_tab :forums
  
  def index
    @forums = Forum.all
  end
  
  def show
    @forum = Forum.find_by_slug(params[:id])
    @topics = @forum.topics.all
    @topic = Topic.new
    @topic.comments.build
  end
  
end
