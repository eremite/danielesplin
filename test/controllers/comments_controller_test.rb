require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  test 'create invalid' do
    login(:child)
    post '/comments', params: { comment: { post_id: posts(:base).id, body: "" } }
    assert_redirected_to posts(:base)
  end

  test 'create as a guest' do
    user = users(:guest).tap(&:grant_access!)
    post '/comments', params: { comment: {
      post_id: posts(:base).id,
      body: 'Cool!',
    }, access_token: user.access_token }
    assert_redirected_to "/posts/#{posts(:base).id}?access_token=#{user.access_token}"
  end

  test 'create as a parent' do
    login(:admin)
    post '/comments', params: { comment: {
      post_id: posts(:base).id,
      body: 'Thanks!',
    } }
    assert_redirected_to posts(:base)
  end

  test 'edit' do
    login(:admin)
    get "/comments/#{comments(:base).id}/edit"
    assert_response :success
  end

  test 'update invalid' do
    login(:admin)
    put "/comments/#{comments(:base).id}", params:{ comment: { post_id: posts(:base).id, body: "" } }
    assert_response :success
  end

  test 'update valid' do
    login(:admin)
    put "/comments/#{comments(:base).id}", params: { id: comments(:base).id, comment: {
      post_id: posts(:base).id,
      body: 'Body',
    } }
    assert_redirected_to posts(:base)
  end

  test 'destroy' do
    login(:admin)
    delete  "/comments/#{comments(:base).id}"
    assert_redirected_to posts(:base)
  end

end
