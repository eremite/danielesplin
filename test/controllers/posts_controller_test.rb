require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  test 'index' do
    login_as(users(:admin))
    get :index
    assert_redirected_to posts(:base)
  end

  test 'new' do
    login_as(users(:admin))
    get :new
    assert_response :success
  end

  test 'create invalid' do
    login_as(users(:admin))
    Post.stub_any_instance :save, false do
      post :create, params: { post: valid_attributes }
    end
    assert_response :success
  end

  test 'create valid' do
    login_as(users(:admin))
    Post.stub_any_instance :save, true do
      post :create, params: { post: valid_attributes }
    end
    assert_redirected_to :posts
  end

  test 'show as guest' do
    user = users(:guest).tap(&:grant_access!)
    get :show, params: { id: posts(:base).id, access_token: user.access_token }
    assert_response :success
  end

  test 'show as child' do
    login_as(users(:child))
    get :show, params: { id: posts(:base).id }
    assert_response :success
  end

  private

  def valid_attributes
    {
      at: Time.zone.now,
      body: 'Body',
    }
  end

end
