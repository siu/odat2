/* Action to increase and store text size */
function increase_text_size() {
  $current = parseFloat( $('#report').css('font-size'), 10);
  change_text_size($current + 1.0);
  $("#report_view").submit();
}

/* Action to decrease and store text size */
function decrease_text_size() {
  $current = parseFloat( $('#report').css('font-size'), 10);
  change_text_size($current - 1.0);
  $("#report_view").submit();
}

/* Reset the text size */
function reset_text_size() {
  change_text_size(14.0);
  $("#report_view").submit();
}

/* Change the text size to a given value */
function change_text_size(new_size) {
  $('#report').css('font-size', new_size);
  $('#report_configurable_view_attributes_font_size').val(new_size);
}

/* Action to enable all borders and store */
function border_all() {
  border_enable();
  $("#report_view").submit();
}

/* Action to disable all borders and store */
function border_none() {
  border_disable();
  $("#report_view").submit();
}

/* Enable all borders */
function border_enable() {
  $('#report td').css('border', '1px solid #222');
  $('#report th').css('border', '1px solid #222');
  $('#report_configurable_view_attributes_table_grid').val(1);
}

/* Disable all borders */
function border_disable() {
  $('#report td').css('border', 'none');
  $('#report th').css('border', 'none');
  $('#report_configurable_view_attributes_table_grid').val(null);
}

/* Set the display properties of a report when the page is loaded */
$(document).ready(function() {
  $("#report_view").submitWithAjax();
  change_text_size(parseFloat($("#report_configurable_view_attributes_font_size").val()));
  if($("#report_configurable_view_attributes_table_grid").val()) {
    border_enable();
  }
})

