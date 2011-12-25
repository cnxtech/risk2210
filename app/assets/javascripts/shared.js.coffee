## Close Flash messages
$ ->
  $("a.close").click ->
    $(this).parent().fadeOut()
    return false
