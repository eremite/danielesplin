require 'test_helper'

class PostPhotosControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'create invalid' do
    PostPhoto.stub_any_instance :save, false do
      post :create, post_photo: valid_attributes
    end
    assert_redirected_to [:edit, posts(:base)]
  end

  test 'create valid' do
    PostPhoto.stub_any_instance :save, true do
      post :create, post_photo: valid_attributes
    end
    assert_redirected_to [:edit, posts(:base)]
  end

  test 'destroy' do
    delete :destroy, id: post_photos(:base).id
    assert_redirected_to [:edit, posts(:base)]
  end



  private

  def valid_attributes
    {
      post_id: posts(:base).id,
      photo_id: photos(:base).id,
    }
  end

end
