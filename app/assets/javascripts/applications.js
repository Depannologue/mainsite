// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require best_in_place
//= require cocoon
//= require_self

$(function(){

  $('label').each(function() {
    $(this).on('click', function(e) {
      $('.is-active').removeClass('is-active');
      $(this).addClass('is-active');
    });
  });

  $('input:checkbox').change(function(){
    if($(this).is(':checked'))
      $(this).parent().addClass('is-checked');
    else
      $(this).parent().removeClass('is-checked')
  });

  $('input:checked').parent('label').addClass('is-checked');

  var shrinkHeader = 80;
  $(window).scroll(function() {
    var scroll = getCurrentScroll();
      if ( scroll >= shrinkHeader ) {
           $('.navbar').addClass('shrink');
        }
        else {
            $('.navbar').removeClass('shrink');
        }
  });
  function getCurrentScroll() {
    return window.pageYOffset || document.documentElement.scrollTop;
  }

  // OFF CANVAS NAVIGATION MENU
  // document.getElementsByClassName
  var hamburger = $(".hamburger"),
      close = $(".close-menu"),
      overlay = $(".overlay"),
      menu = $(".off-canvas");

  hamburger.on("click", function() {
    overlay.addClass("active");
    menu.addClass("opened");
  });

  close.on("click", function() {
    closeMenu();
  });

  overlay.on("click", function() {
    closeMenu();
  });

  var closeMenu = function() {
    overlay.removeClass("active");
    menu.removeClass("opened");
  };

});
