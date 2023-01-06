require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_redirected_to posts(:base)
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create invalid' do
    Post.stub_any_instance :save, false do
      post :create, params: { post: valid_attributes }
    end
    assert_response :success
  end

  test 'create valid' do
    Post.stub_any_instance :save, true do
      post :create, params: { post: valid_attributes }
    end
    assert_redirected_to :posts
  end


  private

  def valid_attributes
    {
      at: Time.zone.now,
      body: 'Body',
    }
  end

end
