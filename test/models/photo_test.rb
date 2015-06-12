require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  test 'valid' do
    assert photos(:base).valid?
  end

  test 'google_plus_remote_image_url=' do
    photo = photos(:base)
    photo.google_plus_remote_image_url = 'https://lh3.googleusercontent.com/00w8Ptl5Y0MrrHm139oS9-d55h7QFJjc2EOatXldc6x=w123-h456-no'
    assert_equal 'https://lh3.googleusercontent.com/00w8Ptl5Y0MrrHm139oS9-d55h7QFJjc2EOatXldc6x=w9999-h9999-no', photo.remote_image_url
  end

  test 'handle hidden' do
    skip
  end

  test 'auto_assign_entries' do
    skip
  end

end
