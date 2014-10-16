(function() {
  var renderEntries;

  jQuery(function() {
    $('.datetimepicker').datetimepicker({
      dateFormat: 'm/d/yy',
      timeFormat: 'h:mmtt',
      ampm: true,
      altFormat: 'yy-mm-dd',
      altTimeFormat: 'hh:mm:ss TT z',
      altField: '.datetimepicker-hidden',
      altFieldTimeOnly: false,
      useLocalTimezone: true,
      showTimezone: false,
      showSecond: false
    });
    $('.datepicker').datepicker();
    $('.autofocus:first').focus();

    if (!localStorage['entries']) {
      localStorage['entries'] = JSON.stringify([]);
    } else {
      renderEntries();
    }

    $('form#new_entry').on('submit', function(e) {
      e.preventDefault();
      if ($('#at').val().length === 0 || $('#entry_body').val().length === 0 || $('#api_key').val().length === 0) {
        alert("Date or Content or API Key is empty!"); return;
      }
      var entries, entry;
      entries = $.parseJSON(localStorage['entries']);
      entry = {
        title: '' + $('#api_key').val() + ' ' + $('#at').val(),
        body: $('#entry_body').val(),
        data: $(this).serialize()
      };
      entries.push(entry);
      localStorage['entries'] = JSON.stringify(entries);
      renderEntries();
      this.reset();
    });

    return $('a#sync-with-server').on('click', function(e) {
      var entries, entry, i, length;
      entries = $.parseJSON(localStorage['entries']);
      for (i = 0, length = entries.length; i < length; i++) {
        entry = entries[i];
        $.ajax({
          type: 'POST',
          url: '/api/entries',
          data: entry.data,
          success: function() {
            console.log('Uploaded', entry);
          },
          error: function(data) {
            alert(data.responseText);
            $('ul.errors').append('<li>' + entry.title + ' - ' + entry.body + '</li>');
          }
        });
      }
      localStorage['entries'] = JSON.stringify([]);
      renderEntries();
      return e.preventDefault();
    });
  });

  renderEntries = function() {
    var entry, _i, _len, _ref, _results;
    $('ul.entries').empty();
    _ref = $.parseJSON(localStorage['entries']);
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entry = _ref[_i];
      _results.push($('ul.entries').append("<li>" + entry.title + "</li>"));
    }
    return _results;
  };

}).call(this);
