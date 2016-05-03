$(".js-intervention-kind").on('click', function(e) {
  e.preventDefault();
  var $form = $(this).closest("form");
  $(this).find('input').prop('checked', true);
  $form.submit();
});
