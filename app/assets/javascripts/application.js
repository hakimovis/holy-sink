// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory,   lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require_tree .


$(window).on('load', function() {
	init();
});

function init() {
	$('.day-status').click(function() {
		el = $(this);
		$.post('', {id: $(this)[0].id }, function(data) {
			el.siblings(".selected").removeClass('selected').addClass('bg-light');
			el.addClass('selected').removeClass('bg-light');
		})
	});
	$('.day-status').hover(
		function() {
			if($(this)[0].classList.contains('selected')) {
				return;
			};
			$(this).removeClass('bg-light');
		},
		function() {
			if($(this)[0].classList.contains('selected')) {
				return;
			};
			$(this).addClass('bg-light');
		}
	);

	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
	  return new bootstrap.Tooltip(tooltipTriggerEl)
	});

	$('.comment-field').change(function() {
		el = $(this)[0];
		id = el.id;
		value = el.value;
		$.post('/my_days/comments', {id: id, value: value }, function(data) {})
	})
}