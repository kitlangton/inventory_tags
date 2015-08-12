typeAhead = ->

$ ->
  if $(".typeahead").size() > 0
    colors = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.whitespace
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch: '/colors.json'
    )
    manufacturers = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.whitespace
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch: '/tags.json'
    )

    $('.typeahead-color').typeahead(null, {
      name: 'colors',
      source: colors
    })

    $('.typeahead-manufacturer').typeahead(null, {
      name: 'manufacturers',
      source: manufacturers
    })
