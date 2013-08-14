// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require twitter/bootstrap
//= require_tree .

RP = {
  setup: function() {
    // construct new DOM elements
    $('<label for="filter" class="explanation">' +
      'Restrict to movies suitable for children' +
      '</label>' +
      '<input type="checkbox" id="filter" />'
    ).insertBefore('#movies').change(RP.filter_adult);
  },
  filter_adult: function() {
    // 'this' is element that received event from checkbox action
    if ($(this).is(':checked')) {
      $('#movies tbody tr').each(RP.hide_if_adult_row);
    } else {
      $('#movies tbody tr').show();
    }
  },
  hide_if_adult_row: function() {
    if (! /^G|PG$/i.test($(this).find('td:nth-child(2)').text())) {
      $(this).hide();
    }
  }
};
$(RP.setup);


