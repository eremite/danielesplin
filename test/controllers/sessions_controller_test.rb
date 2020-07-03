require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create invalid' do
    User.stub_any_instance :authenticate, nil do
      post :create
    end
    assert_response :success
    assert_nil session['user_id']
  end

  test 'create valid' do
    u = users(:base)
    User.stub_any_instance :authenticate, u do
      assert_difference lambda { LogEntry.logins.count } do
        post :create, params: { email: u.email }
      end
    end
    assert_redirected_to :public_posts
    assert_equal u.id, session['user_id']
  end

  test 'create valid admin, without todays entry' do
    u = users(:admin)
    u.entries.delete_all
    User.stub_any_instance :authenticate, u do
      assert_difference lambda { LogEntry.logins.count } do
        post :create, params: { email: u.email }
      end
    end
    assert_redirected_to new_entry_url
    assert_equal u.id, session['user_id']
  end

end
