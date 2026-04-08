require 'test_helper'

class PostPhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    login(:admin)
  end

  test 'create' do
    post '/post_photos', params: { post_photo: valid_attributes }
    assert_redirected_to "/posts/#{posts(:base).id}/edit"
  end

  test 'destroy' do
    delete "/post_photos/#{post_photos(:base).id}"
    assert_redirected_to "/posts/#{posts(:base).id}/edit"
  end

  private

  def valid_attributes
    {
      post_id: posts(:base).id,
      photo_id: photos(:base).id
    }
  end
end
