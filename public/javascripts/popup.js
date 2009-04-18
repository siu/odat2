var _POPUP_FEATURES = 'location=0,\
	menubar=1,\
	width=520,\
	height=420,\
	scrollbars=yes\
';

function raw_popup(url, target, features) {
	if (isUndefined(features)) {
		features = _POPUP_FEATURES;
	}
	if (isUndefined(target)) {
		target = '_blank';
	}
	var theWindow =window.open(url, target, features);
	theWindow.focus();
	return theWindow;
}

function link_popup(src, features) {
	return raw_popup(src.getAttribute('href'), src.getAttribute('target') || '_blank', features);
}

function isUndefined(v) {
	var undef;
	return v===undef;
}

