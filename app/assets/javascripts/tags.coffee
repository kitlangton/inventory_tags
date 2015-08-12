$ ->
  currentTallest = 0
  currentRowStart = 0
  rowDivs = new Array
  $el = undefined
  topPosition = 0
  $('.tag').each ->
    $el = $(this)
    topPosition = $el.position().top
    if currentRowStart != topPosition
      # we just came to a new row.  Set all the heights on the completed row
      currentDiv = 0
      while currentDiv < rowDivs.length
        rowDivs[currentDiv].height currentTallest
        currentDiv++
      # set the variables for the new row
      rowDivs.length = 0
      # empty the array
      currentRowStart = topPosition
      currentTallest = $el.height()
      rowDivs.push $el
    else
      # another div on the current row.  Add it to the list and check if it's taller
      rowDivs.push $el
      currentTallest = if currentTallest < $el.height() then $el.height() else currentTallest
    # do the last row
    currentDiv = 0
    while currentDiv < rowDivs.length
      rowDivs[currentDiv].height currentTallest
      currentDiv++
    return



$ ->
  $(".cart-status").on 'click', ->
    if $(@).hasClass "added"
      $(@).closest(".tag").find(".cart-added").velocity
        width: "10px"
        paddingRight: "5px"
      ,
        "100"
      $(@).removeClass "added"
    else
      $(@).addClass "added"
      $(@).closest(".tag").find(".cart-added").velocity
        width: "75px"
        paddingRight: "12px"
      ,
        "spring"
