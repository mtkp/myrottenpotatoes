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

    // add invisible div to end of page
    $('<div id="movieInfo"></div>').hide().appendTo($('body'));
    $('#movies a').click(RP.getMovieInfo);
  },

  filter_adult: function() {
    // 'this' is element that received event from checkbox action
    if ($(this).is(':checked')) {
      $('#movies tr.adult').hide();
    } else {
      $('#movies tbody tr').show();
    }
  },

  getMovieInfo: function() {
    $.ajax({type: 'GET',
            url: $(this).attr('href'),
            timeout: 5000,
            success: RP.showMovieInfo,
            error: function() {alert('Error!');}
          });
    return(false);
  },

  showMovieInfo: function(data) {
    // center a floater 1/2 as wide and 1/4 as tall as screen
    var oneFourth = Math.ceil($(window).width() / 4);
    $('#movieInfo').html(data).
      css({'left': oneFourth, 'width': 2*oneFourth, 'top': 250}).show();
    $('closeLink').click(RP.hideMovieInfo);
    return(false);
  },


  hideMovieInfo: function() {
    $('#movieInfo').hide();
    return(false);
  }
};

$(document).ready(RP.setup);
$(document).on('page:load', RP.setup);

