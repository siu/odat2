function increase_text_size() {
	$current = parseFloat( $('#report').css('font-size'), 10);
	change_text_size($current + 1);
}

function decrease_text_size() {
	$current = parseFloat( $('#report').css('font-size'), 10);
	change_text_size($current - 1);
}

function change_text_size(new_size) {
	size = new_size / 14;
	$('#report').css('font-size', size + 'em');
}

function border_all() {
	$('#report td').css('border', '1px solid #222');
	$('#report th').css('border', '1px solid #222');
}

function border_none() {
	$('#report td').css('border', 'none');
	$('#report th').css('border', 'none');
}
