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
        data: $(this).serialize()
      };
      entries.push(entry);
      localStorage['entries'] = JSON.stringify(entries);
      renderEntries();
      this.reset();
    });

    return $('a#sync-with-server').on('click', function(e) {
      var entry, _i, _len, _ref;
      _ref = $.parseJSON(localStorage['entries']);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        entry = _ref[_i];
        $.ajax({
          type: 'POST',
          url: '/api/entries',
          data: entry.data,
          success: function() {
            var entries;
            entries = $.parseJSON(localStorage['entries']);
            entries = $.map(entries, function(n, i) {
              if (n.data === entry.data) {
                return null;
              } else {
                return n;
              }
            });
            localStorage['entries'] = JSON.stringify(entries);
            return renderEntries();
          },
          error: function(data) {
            return alert(data.responseText);
          }
        });
      }
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
