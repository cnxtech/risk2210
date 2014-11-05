class ForumsController < ApplicationController

  active_tab :forums

  def index
    @forums = Forum.all
  end

  def show
    @forum = Forum.find(params[:id])
    raise Mongoid::Errors::DocumentNotFound.new(Forum, params[:id], params[:id]) if @forum.nil?
    @topics = @forum.topics.all
    @topic = Topic.new
    @topic.comments.build
  end

end
