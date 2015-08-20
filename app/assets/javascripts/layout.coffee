hideAlert = ()->
  $(".alert").addClass "hide"

$ ->
  $(".alert").removeClass "hide"
  setTimeout hideAlert, 3000
  $(".alert").hover ->
    hideAlert()
