checkEnter = (e) ->
  e = e or event
  txtArea = /textarea/i.test((e.target or e.srcElement).tagName)
  txtArea or (e.keyCode or e.which or e.charCode or 0) != 13

$ ->
  $('.swatch').each (i, td) ->
    $(@).css
      'background-color': $(@).data('color')
  $("td").keypress checkEnter
  $("td").keyup ->
    $(@).find("input").val($(@).text())
  $('form').submit ->
    $(".pure-button").text("Submitting...")
    $(".pure-button").attr("disabled", true)

  $('.swatch').minicolors
    theme: 'kit'
    change: (hex, opacity) ->
      $(@).closest(".swatch").css
        'background-color': hex
      $(@).closest(".swatch").find("input").val(hex)
  $('.minicolor-field').minicolors
    change: (hex, opacity) ->
      $(@).css
        'background-color': hex

