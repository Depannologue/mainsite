// Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

// var show_error, stripeResponseHandler;
// $("#payment-form").submit(function (event) {
//   var $form;
//   $form = $(this);
//   $form.find("input[type=submit]").prop("disabled", true);
//   Stripe.card.createToken($form, stripeResponseHandler);
//   return false;
// });

// stripeResponseHandler = function (status, response) {
//   var $form, token;
//   $form = $("#payment-form");
//   if (response.error) {
//     show_error(response.error.message);
//     $form.find("input[type=submit]").prop("disabled", false);
//   } else {
//     $form.trigger('getTokenSuccess');
//     token = response.id;
//     $form.append($("<input type=\"hidden\" name=\"card_token\" />").val(token));
//     $("[data-stripe=number]").remove();
//     $("[data-stripe=cvc]").remove();
//     $("[data-stripe=exp-year]").remove();
//     $("[data-stripe=exp-month]").remove();
//     $form.get(0).submit();
//   }
//   return false;
// };

// show_error = function (message) {
//   $("#flash-messages").html('<div class="alert fade in alert-warning"><button type="button" class="close" data-dismiss="alert">&times;</button>' + message + '</div>');
//   $('.alert').delay(5000).fadeOut(3000);
//   return false;
// };

// $("#payment-form").on('getTokenSuccess', function(e) {
//   $(this).find('.icon').hide();
//   $(this).find('.field').hide();
//   $(this).find('.loader').removeClass('hide');
// })
