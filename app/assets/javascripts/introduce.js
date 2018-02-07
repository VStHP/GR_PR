// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery.min
//= require rails-ujs
//= require jquery.turbolinks
//= require turbolinks
//= require_tree ../../../vendor/assets/javascripts/introduce




$(document).on('click', '#registry', function(){
  var head_elmnt = $('#registry');
  var elmnt = document.getElementById("registry-div");
  head_elmnt.addClass('active');
  $('#login-prime').fadeOut(400);
  $('#home, #contact, #login').removeClass('active');
  elmnt.scrollIntoView({ behavior: 'smooth', block: 'start' });
  return false;
});
$(document).on('click', '#home', function(){
  var head_elmnt = $('#home');
  head_elmnt.addClass('active');
  $('#login-prime').fadeOut(400);
  $('#registry, #contact, #login').removeClass('active');
  $('html, body').animate({scrollTop: 0}, 700);
  return false;
});
$(document).on('click', '#contact', function(){
  var head_elmnt = $('#contact');
  var elmnt = document.getElementById("contact-div");
  head_elmnt.addClass('active');
  $('#login-prime').fadeOut(400);
  $('#home, #registry, #login').removeClass('active');
  elmnt.scrollIntoView({ behavior: 'smooth', block: 'start' });
  return false;
});
$(document).on('click', '#login', function(){
  var head_elmnt = $('#login');
  head_elmnt.addClass('active');
  $('#home, #registry, #contact').removeClass('active');
  $('#login-prime').fadeIn(400);
  return false;
});
$(document).on('click', '#cancel-button', function(){
  $('#login-prime').fadeOut(400);
});
