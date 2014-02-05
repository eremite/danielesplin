# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  $('form.new_saved_file').fileupload({
    autoUpload: true,
    paramName: 'saved_file[attachment]',
  })
