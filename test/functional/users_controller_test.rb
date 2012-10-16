require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:base)
    login_as(@user)
  end

  test 'edit' do
    get :edit, id: @user.id
    assert_template :edit
  end

  test 'update invalid' do
    User.any_instance.stubs(valid?: false)
    put :update, id: @user.id, user: {}
    assert_template :edit
  end

  test 'update valid' do
    User.any_instance.stubs(valid?: true)
    put :update, id: @user.id, user: {}
    assert_redirected_to edit_user_url(@user)
  end

end
