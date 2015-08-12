$ ->
  $('#cart-download').click ->
    button = $(@)
    button.prop 'disabled', true
    button.text 'Downloading...'
    NProgress.start()
    $.ajax({
      type: 'GET'
      url:  '/cart/process'
      success: (data) ->
        button.prop 'disabled', false
        button.text 'Download All'
        window.location.href = '/cart/download'
        NProgress.done()
        return true
    })
