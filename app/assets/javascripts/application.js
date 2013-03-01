// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require twitter/bootstrap
//= require raphael
//= require morris

jQuery(function() {

  // setup the date picker for selecting blood pressure data
  $('#reading_created_at').datepicker({
    dateFormat: 'yy-mm-dd'
  });

  // setup the morris js graph
  return Morris.Line({
    element: 'readings_chart',
    data: $('#readings_chart').data('readings'),
    xkey: 'created_at',
    ykeys: ['systolic', 'diastolic', 'pulse'],
    labels: ['Systolic', 'Diastolic', 'Pulse']
  });
});
