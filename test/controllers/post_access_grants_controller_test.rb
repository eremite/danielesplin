require 'test_helper'

class PostAccessGrantsControllerTest < ActionController::TestCase

  setup do
    login_as(users(:admin))
  end

  test 'create' do
    post :create, params: { post_access_grant: {
      user_id: users(:base),
      post_id: posts(:base),
    } }
    assert_response :redirect
  end

end
