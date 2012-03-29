module ForumsHelper

  def edit_comment_link(forum, topic, comment)
    return unless comment.player == current_player
    link_to "Edit Comment", edit_forum_topic_comment_path(forum, topic, comment), class: "btn btn-info btn-mini edit-comment-button"
  end

end