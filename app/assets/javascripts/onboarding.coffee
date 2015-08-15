
$ ->
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
      mySeq = [ { e: $(@).closest(".part-1"), p: "transition.slideUpOut" , o: { duration: 500}},
      { e: $(".part-2"), p: "transition.slideUpIn", o: { stagger: 300 } } ]
      $.Velocity.RunSequence(mySeq)
