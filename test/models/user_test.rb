require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'valid' do
    assert users(:base).valid?
  end

  test 'log' do
    user = users(:base)
    user.log_entries.destroy_all
    assert user.log('blog')
    assert user.log_entries.present?
    assert_not_nil user.viewed_blog_at
  end

  test 'father?' do
    assert !User.new(:role => 'mother').father?
    assert User.new(:role => 'father').father?
  end

  test 'mother?' do
    assert !User.new(:role => 'father').mother?
    assert User.new(:role => 'mother').mother?
  end

  test 'guest?' do
    assert !User.new(:role => 'father').guest?
    assert User.new(:role => 'guest').guest?
  end

  test 'users_whose_entries_i_can_edit' do
    guest = users(:base)
    child = users(:child)
    parent = users(:admin)
    assert guest.users_whose_entries_i_can_edit.empty?
    assert parent.users_whose_entries_i_can_edit.include?(parent)
    assert parent.users_whose_entries_i_can_edit.include?(child)
  end

  test 'grant_access' do
    user = User.new
    user.grant_access
    assert_not_nil user.access_token
    assert_not_nil user.access_token_expires_at
  end

  test 'grant_access!' do
    user = users(:base).tap { |u| u.update_columns(access_token: nil, access_token_expires_at: nil) }
    user.grant_access!
    assert_not_nil user.reload.access_token
    assert_not_nil user.access_token_expires_at
  end

  test 'contrast_color' do
    assert_equal '#000000', User.new(color: nil).contrast_color
    assert_equal '#ffffff', User.new(color: '#111111').contrast_color
    assert_equal '#000000', User.new(color: '#eeeeee').contrast_color
  end

end
