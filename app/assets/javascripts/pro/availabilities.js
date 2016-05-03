$(".js-availability-option").on('click', function(e) {
  $form = $(this).closest("form")
  var valuesToSubmit = $form.serialize()
  $.ajax({
    type: "PUT",
    url: $form.attr('action'), //sumbits it to the given url of the form
    data: valuesToSubmit,
    dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
  })
});
