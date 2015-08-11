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
