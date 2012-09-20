class ForumsController < ApplicationController

  active_tab :forums
  
  def index
    @forums = Forum.all
    @page_title = "Forums"
  end
  
  def show
    @forum = Forum.find(params[:id])
    @topics = @forum.topics.all
    @topic = Topic.new
    @topic.comments.build
    @page_title = "#{@forum.name} Forum"
  end
  
end
