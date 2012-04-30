//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require forums

function remove_fields(link) {
  if(confirm("Are you sure?")){
    $(link).prev("input[type=hidden]").val("true");
    $(link).closest(".fields").hide();    
  }
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}
