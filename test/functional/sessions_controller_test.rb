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
    assert_difference lambda { LogEntry.logins.count } do
      post :create, email: u.email
    end
    assert_redirected_to new_entry_url
    assert_equal u.id, session['user_id']
  end

end
