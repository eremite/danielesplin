require 'test_helper'

class PostPhotoTest < ActiveSupport::TestCase

  test 'valid' do
    assert post_photos(:base).valid?
  end

end
