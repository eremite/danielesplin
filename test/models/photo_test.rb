require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  test 'valid' do
    assert photos(:base).valid?
  end

  test 'google_plus_remote_image_url=' do
    photo = photos(:base)
    photo.google_plus_remote_image_url = 'https://lh5.googleusercontent.com/-X_Vgfiu9HIw/UZkx2ZmxcDI/AAAAAAAAKqw/k1NOu-vScu0/w554-h738-no/20130519_141032.jpg'
    assert_equal 'https://lh5.googleusercontent.com/-X_Vgfiu9HIw/UZkx2ZmxcDI/AAAAAAAAKqw/k1NOu-vScu0/d/20130519_141032.jpg', photo.remote_image_url
  end

  test 'entry_options_for_select' do
    photo = photos(:base)
    entry = Entry.create(public: true, at: Time.zone.now, body: 'content')
    options = photo.entry_options_for_select
    assert options.rassoc(nil).present?
    assert options.rassoc(0).present?
    assert options.rassoc(entry.id).present?
  end

  test 'handle hidden' do
    pending 'handle_hidden'
  end

  test 'auto_assign_entries' do
    pending 'auto_assign_entries'
  end

end
