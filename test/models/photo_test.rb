require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  test 'valid' do
    assert photos(:base).valid?
  end

  test 'handle hidden' do
    skip
  end

  test 'auto_assign_entries' do
    skip
  end

end
