# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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
