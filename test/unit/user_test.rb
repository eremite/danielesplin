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

  test 'father?' do
    assert !User.new(:role => 'mother').father?
    assert User.new(:role => 'father').father?
  end

  test 'mother?' do
    assert !User.new(:role => 'father').mother?
    assert User.new(:role => 'mother').mother?
  end

  test 'baby?' do
    assert !User.new(:role => 'father').baby?
    assert User.new(:role => 'baby').baby?
  end

end
