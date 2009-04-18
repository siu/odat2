// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function update_main_diagnosis_select(obj, id, name) {
  if(obj.checked) {
    var newsel = new Element('option', {'value': id})
    newsel.update(name)
    $('odat_diagnosis_main_diagnosis_item_id').appendChild(newsel);
  } else {
    var option = $('odat_diagnosis_main_diagnosis_item_id').childElements().find(function(o) {return o.value == id});
    option.remove();
  }

}
