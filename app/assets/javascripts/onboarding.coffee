addToCart = (id) ->
  cart = $('.cart-size')
  new_size = cart.data('size') + 1
  cart.data('size', new_size)
  cart.text cart.data('size')
  cart.velocity
    color: '#0078E7'

deleteFromCart = (id) ->
  cart = $('.cart-size')
  new_size = cart.data('size') - 1
  cart.data('size', new_size)
  cart.text cart.data('size')

$ ->
  $('.plus-callout').click ->
    $('.tag-top').velocity 'callout.bounce'
  if $('.anatomy').size() > 0
    $(".hover").hover(
      ->
        if $(".anatomy").hasClass('no')
          $(".anatomy").velocity 'transition.flipYIn',
            duration: 500
          $(".anatomy").removeClass 'no'
        $(".anatomy .name").text $(@).data 'name'
        $(".anatomy .description").text $(@).data 'description'
      , ->
    )
    $('.example-tag').mouseleave ->
      $(".anatomy").addClass 'no'
      $(".anatomy").velocity 'transition.slideDownOut',
        duration: 500
    $(".next-2").click ->
      $('.cart-status').unbind( 'click' )
      mySeq = [ { e: $(@).closest(".part-1"), p: "transition.slideUpOut" , o: { duration: 500}},
      { e: $(".part-2"), p: "transition.slideUpIn", o: { stagger: 300 } } ]
      $.Velocity.RunSequence(mySeq)

    $(".next-3").click ->
      $('.hover').unbind ( 'mouseenter' )
      mySeq = [ { e: $(@).closest(".part-2"), p: "transition.slideUpOut" , o: { duration: 500}},
      { e: $(".part-3"), p: "transition.slideUpIn", o: { stagger: 300 } } ]
      $.Velocity.RunSequence(mySeq)
      $(".cart-status").on 'click', ->
        if $(@).hasClass "added"
          # deleteFromCart($(@).data('id'))
          # $(@).closest(".tag").find(".cart-added").velocity
          #   width: "10px"
          #   paddingRight: "5px"
          # ,
          #   "100"
          # $(@).removeClass "added"
          # if $('#cart').size() > 0
          #   $(@).closest('.tag').velocity 'transition.expandOut', 200
        else
          addToCart($(@).data('id'))
          $(@).addClass "added"
          $(@).closest(".tag").find(".cart-added").velocity
            width: "75px"
            paddingRight: "12px"
          ,
            "spring"
          $(".messages").velocity
            height: 182;
          mySeq = [ { e: $(".part-3"), p: "transition.slideUpOut" , o: { duration: 500}},
          { e: $(".part-4"), p: "transition.slideUpIn", o: { stagger: 300 } } ]
          $.Velocity.RunSequence(mySeq)
          $("#cart-header").velocity 'callout.tada'
          $(".cart-callout").click ->
            $("#cart-header").velocity(
              backgroundColor: '#FF0').velocity(
              backgroundColor: '#FFF')
                
            $("#cart-header").velocity 'callout.tada'
          $("#cart-header").click ->
            mySeq = [ { e: $(".part-4"), p: "transition.slideUpOut" , o: { duration: 500}}, { e: $(".part-2"), p: "transition.slideUpOut" , o: { duration: 500}},
            { e: $(".part-5"), p: "transition.slideUpIn", o: { stagger: 300 } } ]
            $.Velocity.RunSequence(mySeq)
            $('.cart-status').each ->
              $(@).unbind 'click'
              $(@).addClass 'added'
              $(@).closest('.tag').find(".cart-added").css
                'width': "75px"
                'paddingRight': "12px"
