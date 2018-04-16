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
//= require jquery.turbolinks
//= require rails-ujs
//= require cocoon
//= require date_format
//= require_tree ../../../vendor/assets/javascripts/primary
//= require alertify
//= require frame_youtube
//= require highcharts
//= require chartkick
//= require cocoon_js

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
  $('#avatarSubject').on('change',function(){
    var selectedFile = event.target.files[0];
    var reader = new FileReader();

    var imgtag = document.getElementById('avatar_image_subject');
    imgtag.title = selectedFile.name;

    reader.onload = function(event) {
      imgtag.src = event.target.result;
    };

    reader.readAsDataURL(selectedFile);
  });
  $('.btn-upload-task').on('click',function(){
    $('.pop-task').show();
  });
  $('.btn-upload-link').on('click',function(){
    $('.pop-link').show();
  });
  $(document).on('click', '.close-popup', function(){
    $('.popup-upload').hide();
  });
});

$(document).on('click', '.show-trainer', function(){
  if($('.table-trainer tbody tr:nth-child(5)').css('display') == 'none')
  {
    $('.table-trainer tbody tr:gt(3)').show();
    $(this).text('Ẩn bớt..');
  }else{
    $('.table-trainer tbody tr:gt(3)').hide();
    $(this).text('Xem thêm..');
  }
});
$(document).on('click', '.show-trainee', function(){
  if($('.table-trainee tbody tr:nth-child(5)').css('display') == 'none')
  {
    $('.table-trainee tbody tr:gt(3)').show();
    $(this).text('Ẩn bớt..');
  }else{
    $('.table-trainee tbody tr:gt(3)').hide();
    $(this).text('Xem thêm..');
  }
});
$(document).on('click', '.show-course', function(){
  if($('.table-course tbody tr:nth-child(5)').css('display') == 'none')
  {
    $('.table-course tbody tr:gt(3)').show();
    $(this).text('Ẩn bớt..');
  }else{
    $('.table-course tbody tr:gt(3)').hide();
    $(this).text('Xem thêm..');
  }
});
$(document).on('click','.show-describe', function(){
  if($('#sb-describe').css('display') == 'none')
  {
    $('#sb-describe').show();
    $(this).text('Ẩn bớt..');
  }else{
    $('#sb-describe').hide();
    $(this).text('Xem thêm..');
  }
})
$(document).on('click','.open_y', function(){
  var link = $(this).val();
  alertify.YoutubeDialog(link).set({frameless:false});
})
$(document).on('click','.form-title .link', function(){
  if($('.link_fields').css('display') == 'none'){
    $('.link_fields').show(1000);
    $('.form-title .link').html('<i class="fa fa-minus-square"></i> Danh sách liên kết bổ sung');
  }else{
    $('.link_fields').hide(1000);
    $('.form-title .link').html('<i class="fa fa-plus-square"></i> Danh sách liên kết bổ sung');
  }
});
$(document).on('click','.form-title .task', function(){
  if($('.task_fields').css('display') == 'none'){
    $('.task_fields').show(1000);
    $('.form-title .task').html('<i class="fa fa-minus-square"></i> Danh sách chương của môn học');
  }else{
    $('.task_fields').hide(1000);
    $('.form-title .task').html('<i class="fa fa-plus-square"></i> Danh sách chương của môn học');
  }
});
$(document).on('click', '.load-spinner', function(){
  $('.spinner').delay(500).show(0);
});
$(document).on('click', '#survey_type_test', function(){
  if( $('#survey_type_test').is(':checked') ){
    $('.selections-task').hide(500);
  }
  else{
    $('.selections-task').show(500);
  }
});

$(document).on('click', '#survey_subject_id_chosen .chosen-drop .chosen-results li', function(){
    $('.spinner').show();
    var name = $(this).text();
    $.ajax({
      url: "/admin/surveys/reload/lessons/"+name
    });
  });
  $(document).ready(function(){
    if( $('#survey_type_test').is(':checked') ){
      $('.selections-task').hide(500);
    }
    else{
      $('.selections-task').show(500);
    }
  });

