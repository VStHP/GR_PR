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
//= require alertify
//= require jquery.countdown
jQuery(function(){
    var countdown = $('#remaining_time').val()*1000;
    var timerId = setInterval(function(){
      countdown -= 1000;
      var min = Math.floor(countdown / (60 * 1000));
      var sec = Math.floor((countdown - (min * 60 * 1000)) / 1000);

      if (countdown <= 0) {
        alertify.alert("Hết thời gian làm bài");
        setTimeout(function() { $("#new_exam_lesson").submit(); }, 3000);
        clearInterval(timerId);
      } else {
         $("#countTime").html(min + " : " + sec);
      }
}, 1000);
});
