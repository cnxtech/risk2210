$(".nested_comment_link").click ->
  $(this).siblings('.comment_form_container').slideToggle()
  return false

$(".nested-comment-cancel-button").on "click", ->
  $(this).parents().closest('.comment_form_container').slideToggle()
  return false
