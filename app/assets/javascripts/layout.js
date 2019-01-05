$(document).ready(function() {

  // Autofocus
  $('.autofocus:first').focus()

  // Fancybox
  $('.fancybox').fancybox({
    preload: 50,
  })

  // Autosize
  $('textarea#post_body, textarea#entry_body').autosize()

  // Datetimepicker
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
    showSecond: false,
  })

  // Datepicker
  $('.datepicker').datepicker()

  // jQuery File Upload
  $('form.new_photo').fileupload({
    autoUpload: true,
    paramName: 'photo[image]',
  })
  $('form.new_photo').on('fileuploadsubmit', function(e, data) {
    inputs = data.context.find(':input')
    data.formData = inputs.serializeArray()
  })
  $('form.new_saved_file').fileupload({
    autoUpload: true,
    paramName: 'saved_file[attachment]',
  })

  // Make inserting common tags easier.
  $('span.insert-into-tag-list').on('click', function() {
    input = $(this).parent().siblings('input')
    if (input.val()) {
      input.val(input.val() + ', ' + this.innerHTML)
    } else {
      input.val(this.innerHTML)
    }
    $(this).remove()
  })

})

// Not sure why/if this has to be global...
fileUploadErrors = {
  maxFileSize: 'File is too big',
  minFileSize: 'File is too small',
  acceptFileTypes: 'Filetype not allowed',
  maxNumberOfFiles: 'Max number of files exceeded',
  uploadedBytes: 'Uploaded bytes exceed file size',
  emptyResult: 'Empty file upload result',
}
