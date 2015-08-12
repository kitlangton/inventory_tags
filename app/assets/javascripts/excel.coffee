checkEnter = (e) ->
  e = e or event
  txtArea = /textarea/i.test((e.target or e.srcElement).tagName)
  txtArea or (e.keyCode or e.which or e.charCode or 0) != 13

$ ->
  $('.swatch').each (i, td) ->
    $(@).css
      'background-color': $(@).data('color')
  $('.gb').each (i, td) ->
    matched_text = $(@).text().match /\d+/
    if matched_text
      $(@).text matched_text
      $(@).addClass "has-gb"
    else
      $(@).text ""
  $("td").keypress checkEnter
  $("td").keyup ->
    $(@).find("input").val($(@).text())
  # $(".gb").keyup ->
  #   $(@).closest("tr").find(".tag-size-field").val($(@).text())
  # $(".gb").focus ->
  #   $(@).addClass "has-gb"
  # $(".gb").blur ->
  #   text = $(@).text().match /\d+/ or ""
  #   if text
  #     $(@).text text
  #     $(@).addClass "has-gb"
  #   else
  #     $(@).text ""
  #     $(@).removeClass "has-gb"
  #
  #
  # $(".swatch").keypress (e) ->
  #   return !(!~[37, 38, 39, 40].indexOf(e.keyCode) && !e.ctrlKey)
  # $('form').submit ->
  #   $(".pure-button").text("Submitting...")
  #   $(".pure-button").attr("disabled", true)
  # $('.swatch').minicolors
  #   theme: 'kit'
  #   change: (hex, opacity) ->
  #     $(@).closest(".swatch").css
  #       'background-color': hex
  #     $(@).closest(".swatch").find("input").val(hex)
  # $('.minicolor-field').minicolors
  #   change: (hex, opacity) ->
  #     $(@).css
  #       'background-color': hex
