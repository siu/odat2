// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function update_main_diagnosis_select(obj, id, name) {
  if(obj.checked) {
    $('#odat_diagnosis_main_diagnosis_item_id').append('<option value="' + id + '">' +name+ '</option>');
  } else {
    var option = $('#odat_diagnosis_main_diagnosis_item_id option[value='+id+']');
    option.remove();
  }

}
