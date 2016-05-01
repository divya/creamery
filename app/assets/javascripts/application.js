// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation.min
//= require_tree .

$(function() {
  $(document).foundation('topbar', 'reflow');
});

function renderNewShiftForm() {
	$('#new_shift_link').remove();
	$("#shift_form").show();
}

function removeShiftForm() {
	$("#shift_form").remove();
	$('#new_shift_link').show();
}

function removeJobForm() {
	$('#new_job_form').remove();
	$('#new_job_link').show();
}

function removeFlavorForm() {
	$('#new_store_flavor_form').remove();
	$('#new_store_flavor_link').show();
}

// Datepicker code
$(function() {
  $(".datepicker").datepicker({
    format: 'mm/dd/YYYY'
  });
});
