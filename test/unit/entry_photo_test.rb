require 'test_helper'

class EntryPhotoTest < ActiveSupport::TestCase

  test 'valid' do
    assert entry_photos(:base).valid?
  end

end
