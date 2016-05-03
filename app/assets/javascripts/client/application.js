//= require ../application
//= require_tree .
//= require_self

$(document).ready(function() {
  $("#myBtn").click(function(){
    $("#myModal").modal();
  });

  $(".dropdown-aside").hide()
  $(".more-info .dropdown .dropaction").click(function(e){
    e.preventDefault();
    $(this).parent().find(".dropdown-aside").toggle({duration: 250});
    $("i",this).toggleClass("icon-chevron-down icon-chevron-up");
  });

  $(function() {
    // init variables
    var nextBtn = $(".tutoriel-modal .action-next"),
        endBtn = $(".btn.action-end"),
        startBtn = $(".btn.action-start"),
        prevBtn = $(".tutoriel-modal .action-prev"),
        removeAnimations = "animation-exit animation-exit-invert animation-entrance";

    // Lorsqu'on clique sur suivant
    nextBtn.on('click', function(e) {
      e.preventDefault();
      var currentDataArticle = $(this).parents().eq(3).data("article"),
          currentArticle = $(this).parents().eq(3),
          nextNbr = currentDataArticle + 1,
          nextArticle = $(".tutoriel-modal").filter('[data-article="'+ nextNbr +'"]');

      currentArticle.addClass("animation-exit");
      currentArticle.removeClass("animation-entrance");
      nextArticle.removeClass(removeAnimations);
      nextArticle.addClass("tutoriel-show animation-entrance");
    });

    // Lorsqu'on clique sur précédent
    prevBtn.on('click', function(e) {
      e.preventDefault();
      var currentDataArticle = $(this).parents().eq(3).data("article"),
          currentArticle = $(this).parents().eq(3),
          prevNbr = currentDataArticle - 1,
          prevArticle = $(".tutoriel-modal").filter('[data-article="'+ prevNbr +'"]');

      currentArticle.addClass("animation-exit-invert");
      currentArticle.removeClass("animation-entrance");
      prevArticle.removeClass(removeAnimations);
      prevArticle.addClass("tutoriel-show animation-begin");
    });

    endBtn.on('click', function(e) {
      e.preventDefault();
      $(".tutoriel-modal").removeClass(removeAnimations);
      $(".tutoriel-modal").removeClass("tutoriel-show");
    });

    startBtn.on('click', function(e) {
      e.preventDefault();
      $(".tutoriel-modal").filter('[data-article="1"]').addClass("tutoriel-show animation-entrance");
    });
  });

});
