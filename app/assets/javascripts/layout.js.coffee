## Close Flash messages
$("a.close").click ->
  $(this).parent().fadeOut()
  return false

## Navigation menus
$("body").click ->
  $('.dropdown-toggle, .menu').parent("li").removeClass("open")

$(".dropdown-toggle, .menu").click ->
  $(this).parent("li").toggleClass('open')
  return false
