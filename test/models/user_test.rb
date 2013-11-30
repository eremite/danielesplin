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

  test 'guest?' do
    assert !User.new(:role => 'father').guest?
    assert User.new(:role => 'guest').guest?
  end

  test 'users_whose_entries_i_can_edit' do
    guest = users(:base)
    baby = users(:baby)
    parent = users(:admin)
    assert guest.users_whose_entries_i_can_edit.empty?
    assert_equal [baby], baby.users_whose_entries_i_can_edit
    assert parent.users_whose_entries_i_can_edit.include?(parent)
    assert parent.users_whose_entries_i_can_edit.include?(baby)
  end

end
