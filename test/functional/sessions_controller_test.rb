require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    User.any_instance.stubs(authenticate: nil)
    post :create
    assert_template :new
    assert_nil session['user_id']
  end

  test 'create valid' do
    u = users(:base)
    User.any_instance.stubs(authenticate: u)
    post :create, email: u.email
    assert_redirected_to photos_url
    assert_equal u.id, session['user_id']
  end

end
