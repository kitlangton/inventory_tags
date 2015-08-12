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
      currentDiv = 0
      while currentDiv < rowDivs.length
        rowDivs[currentDiv].height currentTallest
        currentDiv++
      rowDivs.length = 0
      currentRowStart = topPosition
      currentTallest = $el.height()
      rowDivs.push $el
    else
      rowDivs.push $el
      currentTallest = if currentTallest < $el.height() then $el.height() else currentTallest
    currentDiv = 0
    while currentDiv < rowDivs.length
      rowDivs[currentDiv].height currentTallest
      currentDiv++
    return

addToCart = (id) ->
  cart = $('.cart-size')
  new_size = cart.data('size') + 1
  cart.data('size', new_size)
  cart.text cart.data('size')
  $.ajax({
    type: "POST",
    url: "/cart",
    data: { id: id },
    success:(data) ->
      alert data.id
      return false
    error:(data) ->
      console.log data
      return false
  })

deleteFromCart = (id) ->
  cart = $('.cart-size')
  new_size = cart.data('size') - 1
  cart.data('size', new_size)
  cart.text cart.data('size')
  $.ajax({
    type: "POST",
    url: "/cart/delete",
    data: { id: id },
    success:(data) ->
      alert data.id
      refreshCart()
      return false
    error:(data) ->
      console.log data
      refreshCart()
      return false
  })

refreshCart = ->
  if $('#cart').size() > 0
    $.ajax({
      type: "get",
      url: "/cart/tags",
      success:(data) ->
        console.log data
        $('.tags-container').html data
        $(document).trigger('page:load')
        return false
      error:(data) ->
        console.log data
        $('.tags-container').html data
        $(document).trigger('page:load')
        return false
    })

$ ->
  $(".cart-status").each ->
    if $(@).hasClass 'added'
      $(@).closest(".tag").find(".cart-added").css
        width: "75px"
        paddingRight: "12px"
  $(".cart-status").on 'click', ->
    if $(@).hasClass "added"
      deleteFromCart($(@).data('id'))
      $(@).closest(".tag").find(".cart-added").velocity
        width: "10px"
        paddingRight: "5px"
      ,
        "100"
      $(@).removeClass "added"
      if $('#cart').size() > 0
        $(@).closest('.tag').velocity 'transition.expandOut', 200
    else
      addToCart($(@).data('id'))
      $(@).addClass "added"
      $(@).closest(".tag").find(".cart-added").velocity
        width: "75px"
        paddingRight: "12px"
      ,
        "spring"
