require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    Photo.any_instance.stubs(save: false)
    post :create, photo: {}
    assert_template :new
  end

  test 'create valid' do
    Photo.any_instance.stubs(save: true)
    post :create, photo: {}
    assert_redirected_to photos_url
  end

end
