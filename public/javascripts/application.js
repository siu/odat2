// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(document).ready(function($) {
  $('#login').focus();
  $('a[rel*=facebox]').facebox()
}) 
//
function update_main_diagnosis_select(obj, id, name) {
  if(obj.checked) {
    $('#odat_diagnosis_main_diagnosis_item_id').append('<option value="' + id + '">' +name+ '</option>');
  } else {
    var option = $('#odat_diagnosis_main_diagnosis_item_id option[value='+id+']');
    option.remove();
  }
}

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

