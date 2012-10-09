require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'valid' do
    assert users(:base).valid?
  end

  test 'log' do
    u = users(:base)
    assert_difference lambda { LogEntry.count } do
      assert u.log('login')
    end
  end

end
