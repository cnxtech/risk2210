$(".nested_comment_link").click ->
  $(this).siblings('.comment_form_container').slideToggle()
  return false