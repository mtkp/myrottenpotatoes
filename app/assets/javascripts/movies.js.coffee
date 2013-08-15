RP =

  setup: ->
    # construct new DOM elements
    $('<label for="filter" class="explanation">' +
      'Restrict to movies suitable for children' +
      '</label>' +
      '<input type="checkbox" id="filter" />'
    ).insertBefore('#movies').click RP.filter_adult

    # add invisible div to end of page for movie info float
    $('<div id="movieInfo"></div>').hide().appendTo $('body')
    $('#movies a').click(RP.getMovieInfo)

  filter_adult: ->
    # 'this' is element that received event from checkbox action
    if $(this).is(':checked')
      $('#movies tr.adult').hide()
    else
      $('#movies tbody tr').show()

  getMovieInfo: ->
    $.ajax
      type: 'GET'
      url: $(this).attr('href')
      timeout: 5000
      success: RP.showMovieInfo
      error: ->
        alert('Error!')
    return false

  showMovieInfo: (data) ->
    # center a floater 1/2 as wide and 1/4 as tall as screen
    oneFourth = Math.ceil($(window).width() / 4)
    $('#movieInfo').html(data).
      css({'left': oneFourth, 'width': 2*oneFourth, 'top': 250}).show()
    $('closeLink').click RP.hideMovieInfo
    return false

  hideMovieInfo: ->
    $('#movieInfo').hide()
    return false


$(document).ready(RP.setup);
$(document).on('page:load', RP.setup);

