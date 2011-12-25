module TopicsHelper
  
  def format_comment(comment)
    MARKDOWN_RENDERER.render(comment).html_safe
  end
  
end
