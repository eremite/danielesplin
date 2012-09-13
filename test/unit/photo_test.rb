require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  test 'valid' do
    assert photos(:base).valid?
  end

end
