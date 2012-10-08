require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'valid' do
    assert users(:base).valid?
  end

end
