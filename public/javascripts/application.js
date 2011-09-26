// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

jQuery(document).ready(function($) {
  $('#user_session_login').focus();
  $('a[rel*=facebox]').facebox();

  $("ul.subnav").parent().addClass("navcat");

  $("ul.subnav").parent().append("<span></span>");

  $("li.navcat span, li.navcat").hover(function() { //When hover the menu

    //Following events are applied to the subnav itself (moving subnav up and down)
    $(this).parent().find("ul.subnav").show(); //Drop down the subnav

    $(this).parent().hover(function() {
      }, function(){
      $(this).parent().find("ul.subnav").hide(); //When the mouse hovers out of the subnav, hide it again
      });

    //Following events are applied to the trigger (Hover events for the trigger)
    }).hover(function() {
      $(this).addClass("subhover"); //On hover over
      }, function(){	//On Hover Out
      $(this).removeClass("subhover");
      });
}) 
//
function update_main_diagnosis_select(checked, id, name) {
  if(checked) {
    $('#odat_diagnosis_main_diagnosis_item_id').append('<option value="' + id + '">' +name+ '</option>');
  } else {
    var option = $('#odat_diagnosis_main_diagnosis_item_id option[value='+id+']');
    option.remove();
  }
}
function hide_flash() {
  $('#flash').slideUp();
}
