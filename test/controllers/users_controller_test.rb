require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'index' do
    login_as(users(:admin))
    get :index
    assert_template :index
  end

  test 'new' do
    login_as(users(:admin))
    get :new
    assert_template :new
  end

  test 'create invalid' do
    login_as(users(:admin))
    User.any_instance.stubs(save: false)
    post :create, user: {}
    assert_template :new
  end

  test 'create valid' do
    login_as(users(:admin))
    User.any_instance.stubs(save: true)
    post :create, user: {}
    assert_redirected_to users_url
  end

  test 'edit' do
    login_as(users(:base))
    get :edit, id: users(:base).id
    assert_template :edit
  end

  test 'update invalid' do
    login_as(users(:base))
    User.any_instance.stubs(valid?: false)
    put :update, id: users(:base).id, user: {}
    assert_template :edit
  end

  test 'update valid' do
    login_as(users(:base))
    User.any_instance.stubs(valid?: true)
    put :update, id: users(:base).id, user: {}
    assert_redirected_to edit_user_url(users(:base))
  end

  test 'destroy' do
    login_as(users(:admin))
    delete :destroy, id: users(:base).id
    assert_redirected_to users_url
  end

end
