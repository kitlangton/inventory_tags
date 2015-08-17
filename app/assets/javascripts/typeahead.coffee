typeAhead = ->

$ ->
  if $(".typeahead").size() > 0
    colors = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.whitespace
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch:
        url: '/colors.json'
        cache: false
    )
    manufacturers = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.whitespace
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch:
        url: '/tags.json'
        cache: false
    )

    $('.typeahead-color').typeahead(null, {
      name: 'colors',
      source: colors
    })

    $('.typeahead-manufacturer').typeahead(null, {
      name: 'manufacturers',
      source: manufacturers
    })
