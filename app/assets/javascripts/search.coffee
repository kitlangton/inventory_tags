$ ->
  $('.pagination > a').on 'click', ->
    $.getScript @href
    false
  $('#search').submit ->
    $.get '/tags', $('#tags_search').serialize(), null, 'script'
    false
  return
