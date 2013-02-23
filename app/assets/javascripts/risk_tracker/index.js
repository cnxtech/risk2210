//= require underscore-min
//= require backbone-min
//= require jquery.animate-shadow-min
//= require fastclick

//= require ./application
//= require ./util
//= require_tree ./templates
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views

window.addEventListener('load', function() {
  new FastClick(document.body);
}, false);
