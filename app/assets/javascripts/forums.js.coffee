$(".nested_comment_link").click ->
  $(this).siblings('.comment_form_container').slideToggle()
  return false

$(".nested_comment_cancel_button").click ->
  $(this).parents().closest('.comment_form_container').slideToggle()
  return false