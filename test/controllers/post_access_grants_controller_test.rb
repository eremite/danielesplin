require 'test_helper'

class PostAccessGrantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login(:admin)
  end

  test 'create' do
    post '/post_access_grants', params: { post_access_grant: {
      user_id: users(:base).id,
      post_id: posts(:base).id
    } }
    assert_response :redirect
  end
end
