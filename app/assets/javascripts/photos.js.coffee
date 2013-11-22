# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  $('#photo_hidden').change ->
    if $(this).prop('checked')
      $('#photo_entry_ids').hide('slow')
    else
      $('#photo_entry_ids').show('slow')
  .trigger('change')

  # jQuery File Upload
  $('#fileupload').fileupload({
    paramName: 'photo[image]',
  })

# Not sure why/if this has to be global...
fileUploadErrors = {
  maxFileSize: 'File is too big',
  minFileSize: 'File is too small',
  acceptFileTypes: 'Filetype not allowed',
  maxNumberOfFiles: 'Max number of files exceeded',
  uploadedBytes: 'Uploaded bytes exceed file size',
  emptyResult: 'Empty file upload result',
}
