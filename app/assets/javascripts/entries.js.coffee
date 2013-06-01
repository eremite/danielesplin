# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  $('.datetimepicker').datetimepicker
    dateFormat: 'm/d/yy',
    timeFormat: 'h:mmtt',
    ampm: true,
    altFormat: 'yy-mm-dd',
    altTimeFormat: 'hh:mm:ss TT z',
    altField: '.datetimepicker-hidden',
    altFieldTimeOnly: false,
    useLocalTimezone: true,

  # Enable autofocus
  $('.autofocus:first').focus()

  # Enable autosize
  $('textarea#entry_body, textarea#entry_baby_body').autosize()
