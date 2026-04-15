require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'create invalid' do
    User.stub_any_instance :authenticate, nil do
      post '/sessions'
    end
    assert_redirected_to '/'
  end

  test 'create valid' do
    user = users(:admin)
    User.stub_any_instance :authenticate, user do
      assert_difference -> { LogEntry.logins.count } do
        post '/sessions', params: { email: user.email }
      end
    end
    assert_redirected_to '/entries'
  end
end
