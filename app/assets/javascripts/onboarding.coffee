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
  $.Velocity.RegisterEffect 'transition.kit',
    defaultDuration: 700,
    calls: [
            [ { color: ['#000', '#00F'], opacity: [1 , 0] , translateY: [0, 20], translateZ: 0 } ],
            [ { color: ['#000', '#FFF'] } ]
        ]

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
            $(@).unbind 'click'
            mySeq = [ { e: $(".part-4"), p: "transition.slideUpOut" , o: { duration: 500}}, { e: $(".part-2"), p: "transition.slideUpOut" , o: { duration: 500}},
            { e: $(".part-5"), p: "transition.slideUpIn", o: { stagger: 300 } } ]
            $.Velocity.RunSequence(mySeq)
            $('.cart-status').each ->
              $(@).unbind 'click'
              $(@).addClass 'added'
              $(@).closest('.tag').find(".cart-added").css
                'width': "75px"
                'paddingRight': "12px"
            cart = $('.cart-size')
            cart.data('size', 3)
            cart.text cart.data('size')
            $('.cart-status').click ->
              deleteFromCart($(@).data('id'))
              $(@).closest(".tag").find(".cart-added").velocity
                width: "10px"
                paddingRight: "5px"
              ,
                "100"
              $(@).closest(".tag").velocity 'transition.expandOut'
              mySeq = [ { e: $(".container.part-5"), p: "transition.slideUpOut" , o: { duration: 500}},
              { e: $(".part-6"), p: "transition.slideUpIn", o: { stagger: 300 } } ]
              $.Velocity.RunSequence(mySeq)
              $(".messages").velocity
                height: 232;
              $('.cart-status').each ->
                $(@).unbind 'click'
              $('.download-all').click ->
                mySeq = [ { e: $(".part-6"), p: "transition.slideUpOut" , o: { duration: 500}}, { e: $(".tag"), p: "transition.slideUpOut" , o: { duration: 500}},
                { e: $(".part-5"), p: "transition.slideUpOut" , o: { duration: 500}},
                { e: $(".part-7"), p: "transition.slideUpIn", o: { stagger: 300 } } ]
                $.Velocity.RunSequence(mySeq)
                $('.con').css
                  display: 'inline-block'
                  'text-align': 'center'
                  'width': '100%'
                $('.congrats').velocity 'transition.kit',
                  display: 'inline-block'
                  stagger: 60
                  drag: true

