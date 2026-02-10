require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  test 'create invalid' do
    login_as(users(:admin))
    post :create, params: { comment: { post_id: posts(:base).id, body: "" } }
    assert_redirected_to posts(:base)
  end

  test 'create as a guest' do
    user = users(:guest).tap(&:grant_access!)
    post :create, params: { comment: {
      post_id: posts(:base).id,
      body: 'Cool!',
    }, access_token: user.access_token }
    assert_redirected_to [posts(:base), access_token: user.access_token]
  end

  test 'create as a parent' do
    login_as(users(:admin))
    post :create, params: { comment: {
      post_id: posts(:base).id,
      body: 'Thanks!',
    } }
    assert_redirected_to posts(:base)
  end

  test 'edit' do
    login_as(users(:admin))
    get :edit, params: { id: comments(:base).id }
    assert_response :success
  end

  test 'update invalid' do
    login_as(users(:admin))
    Comment.stub_any_instance :update, false do
      put :update, params:{ id: comments(:base).id, comment: valid_attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    login_as(users(:admin))
    Comment.stub_any_instance :update, true do
      put :update, params: {id: comments(:base).id, comment: valid_attributes}
    end
    assert_redirected_to :posts
  end

  test 'destroy' do
    login_as(users(:admin))
    delete :destroy, params: { id: comments(:base).id }
    assert_redirected_to :posts
  end

  private

  def valid_attributes
    {
      post_id: posts(:base).id,
      body: 'Body',
    }
  end

end
