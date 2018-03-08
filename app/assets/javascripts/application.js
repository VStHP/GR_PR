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
//= require date_format
//= require_tree ../../../vendor/assets/javascripts/primary
//= require_tree ../../../node_modules/alertify/src

var btnFilterClick = function() {
  return {
    init: function() {
      var btnContainer = document.getElementById("btn-filter-container");
      var btns = btnContainer.getElementsByClassName("btn-filter");
      for (var i = 0; i < btns.length; i++) {
        btns[i].addEventListener("click", function() {
          var current = document.getElementsByClassName("btn-filter active");
          current[0].className = current[0].className.replace(" active", "");
          this.className += " active";
        });
      }
    }
  };
}();

$(document).on('click', '#edit_profile_cancle', function(){
  $('#edit_user_form').remove();
  $('#main-profile-1').show(500);
});

$(document).ready(function(){
  $('#avatarUser').on('change',function(){
    var selectedFile = event.target.files[0];
    var reader = new FileReader();

    var imgtag = document.getElementById('avatar_image');
    imgtag.title = selectedFile.name;

    reader.onload = function(event) {
      imgtag.src = event.target.result;
    };

    reader.readAsDataURL(selectedFile);
  });
  $('#avatarCourse').on('change',function(){
    var selectedFile = event.target.files[0];
    var reader = new FileReader();

    var imgtag = document.getElementById('avatar_image_course');
    imgtag.title = selectedFile.name;

    reader.onload = function(event) {
      imgtag.src = event.target.result;
    };

    reader.readAsDataURL(selectedFile);
  });
  $('#bannerCourse').on('change',function(){
    var selectedFile = event.target.files[0];
    var reader = new FileReader();

    var imgtag = document.getElementById('banner_image_course');
    imgtag.title = selectedFile.name;

    reader.onload = function(event) {
      imgtag.src = event.target.result;
    };

    reader.readAsDataURL(selectedFile);
  });
});
