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

  test 'daniel?' do
    assert !User.new(:email => 'erika@danielesplin.org').daniel?
    assert User.new(:email => 'daniel@danielesplin.org').daniel?
  end

  test 'erika?' do
    assert !User.new(:email => 'daniel@danielesplin.org').erika?
    assert User.new(:email => 'erika@danielesplin.org').erika?
  end

end
