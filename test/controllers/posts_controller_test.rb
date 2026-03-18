require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  test 'index' do
    login(:admin)
    get '/posts'
    assert_redirected_to "/posts/#{posts(:base).id}"
  end

  test 'new' do
    login(:admin)
    get '/posts/new'
    assert_response :success
  end

  test 'create invalid' do
    login(:admin)
    Post.stub_any_instance :save, false do
      post '/posts', params: { post: valid_attributes }
    end
    assert_response :success
  end

  test 'create valid' do
    login(:admin)
    Post.stub_any_instance :save, true do
      post '/posts', params: { post: valid_attributes }
    end
    assert_redirected_to '/posts'
  end

  test 'show as guest' do
    user = users(:guest).tap(&:grant_access!)
    get "/posts/#{posts(:base).id}", params: { id: posts(:base).id, access_token: user.access_token }
    assert_response :success
  end

  test 'show as child' do
    login(:child)
    get "/posts/#{posts(:base).id}"
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
