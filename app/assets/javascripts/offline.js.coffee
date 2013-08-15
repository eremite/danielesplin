# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  if ($('#offline-controller').length)

    if !localStorage['entries']
      localStorage['entries'] = JSON.stringify([])
    else
      renderEntries()

    $('form#new_entry').on 'submit', (e) ->
      entries = $.parseJSON(localStorage['entries'])
      entry = {
        title: "#{$('#at').val()} #{$('#api_key').val()}",
        data: $(this).serialize(),
      }
      entries.push(entry)
      localStorage['entries'] = JSON.stringify(entries);
      renderEntries()
      this.reset()
      e.preventDefault()

    $('a#sync-with-server').on 'click', (e) ->
      for entry in $.parseJSON(localStorage['entries'])
        $.ajax({
          type: 'POST'
          url: '/api/entries'
          data: entry.data
          success: ->
            entries = $.parseJSON(localStorage['entries'])
            entries = $.map entries, (n, i) ->
              if n.data == entry.data
                null
              else
                n
            localStorage['entries'] = JSON.stringify(entries);
            renderEntries()
          error: (data) ->
            alert(data.responseText)
        })
      e.preventDefault()

renderEntries = ->
  $('ul.entries').empty()
  for entry in $.parseJSON(localStorage['entries'])
    $('ul.entries').append("<li>#{entry.title}</li>")
