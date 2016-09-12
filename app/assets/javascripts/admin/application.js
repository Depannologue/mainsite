//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require cocoon

$(function(){

  // Insert new AREA after the olders
  $("#areas a.add_fields").
    data("association-insertion-position", 'before').
    data("association-insertion-node", 'this');

  $('#areas').on('cocoon:after-insert',
   function() {
     $(".user-area-fields a.add_fields").
       data("association-insertion-position", 'before').
       data("association-insertion-node", 'this');
     $('.user-area-fields').on('cocoon:after-insert',
      function() {
        $(this).children("#area_from_list").remove();
        $(this).children("a.add_fields").hide();
      });
   });


  // get area attached to a zipcode
  var get_area_by_zip_code = function(that) {
    var display_area = that.parent('.input').find('.help-block');
    var value = that.val();

    if(value.length){
      $.ajax({
        url: "/areas/zipcode/"+value+".json",
        type: "GET",
        success: function(data) {
          display_area.html("Agglomération liée: "+data);
        },
        error: function(data) {
          display_area.html("Une erreur réseau est survenue.");
        }
      });
    }
  }

  var zipcode_attr = $("input[name='intervention[address_attributes][zipcode]']");

  if(zipcode_attr.length) {
    // post area to div.help-block on keyup zipcode input
    $(zipcode_attr).keyup(function(){
      get_area_by_zip_code($(this));
    });

    // post area to div.help-block on init page
    get_area_by_zip_code(zipcode_attr);
  }

});
