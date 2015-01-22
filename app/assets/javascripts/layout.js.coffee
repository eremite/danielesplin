jQuery ->

  # Autofocus
  $('.autofocus:first').focus()

  # Fancybox
  $('.fancybox').fancybox({
    preload: 50,
  })

  # Autosize
  $('textarea#post_body, textarea#entry_body').autosize()

  # Datetimepicker
  $('.datetimepicker').datetimepicker
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

  # Datepicker
  $('.datepicker').datepicker()

  # Photos: toggle post_ids
  $('#photo_hidden').change ->
    if $(this).prop('checked')
      $('#photo_post_ids').hide('slow')
    else
      $('#photo_post_ids').show('slow')
  .trigger('change')

  # jQuery File Upload
  $('form.new_photo').fileupload({
    autoUpload: true,
    paramName: 'photo[image]',
  })
  $('form.new_photo').bind 'fileuploadsubmit', (e, data) ->
    inputs = data.context.find(':input')
    data.formData = inputs.serializeArray()
  $('form.new_saved_file').fileupload({
    autoUpload: true,
    paramName: 'saved_file[attachment]',
  })

  # Photos: remote image url
  $('#add-google-plus-remote-image-url').click ->
    placeholder = {
      google_plus_remote_image_url: prompt('Paste in the Google+ URL'),
      size: 10000,
      type: 'jpg',
    }
    if (placeholder.google_plus_remote_image_url && placeholder.google_plus_remote_image_url.length)
      $('form.new_photo').fileupload('add', { files: [placeholder] })

  # Photo: insert tag
  $('span.insert-into-photo-tag-list').click ->
    input = $('input#photo_photo_tag_list')
    if input.val()
      input.val("#{input.val()}, #{this.innerHTML}")
    else
      input.val(this.innerHTML)
    $(this).remove()

# Not sure why/if this has to be global...
fileUploadErrors = {
  maxFileSize: 'File is too big',
  minFileSize: 'File is too small',
  acceptFileTypes: 'Filetype not allowed',
  maxNumberOfFiles: 'Max number of files exceeded',
  uploadedBytes: 'Uploaded bytes exceed file size',
  emptyResult: 'Empty file upload result',
}
