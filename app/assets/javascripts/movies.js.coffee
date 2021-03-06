
RP =

  movieCache: {}

  setup: ->
    # construct new DOM elements
    $('<label for="filter" class="explanation">' +
      'Restrict page to movies suitable for children' +
      '</label>' +
      '<input type="checkbox" id="filter" />'
    ).insertBefore('#movies').click RP.filter_adult

    # add invisible div to end of page for movie info float
    $('<div id="movieInfo"></div>').hide().appendTo $('body')
    $('#movies a').hover(RP.getMovieInfo, RP.hideMovieInfo)

  filter_adult: ->
    # 'this' is element that received event from checkbox action
    if $(this).is(':checked')
      $('#movies tr.adult').hide()
    else
      $('#movies tbody tr').show()

  getMovieInfo: ->
    if (RP.movieCache[this.pathname])
      RP.showMovieInfo(RP.movieCache[this.pathname])
    else
      $.ajax
        type: 'GET'
        url: $(this).attr('href')
        timeout: 5000
        success: (data) ->
          RP.movieCache[this.url] = data
          RP.showMovieInfo(data)
        error: ->
          alert('Error!')
    return false

  showMovieInfo: (data) ->
    # center a floater 1/2 as wide and 1/4 as tall as screen
    oneFourthWidth = Math.ceil($(window).width() / 4)
    oneFourthHeight = Math.ceil($(window).height() / 4)
    $('#movieInfo').html(data).
      css({'left': oneFourthWidth, 'width': 2*oneFourthWidth, 'top': oneFourthHeight, 'z-index': 99}).show()
    $('closeLink').click RP.hideMovieInfo
    return false

  hideMovieInfo: ->
    $('#movieInfo').hide()
    return false


$(document).ready(RP.setup);
$(document).on('page:change', RP.setup);

