require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

  test 'index' do
    get :index
    assert_template :index
  end

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    Photo.any_instance.stubs(valid?: false)
    post :create, photo: valid_params
    assert_template :new
  end

  test 'create valid' do
    Photo.any_instance.stubs(valid?: true)
    post :create, photo: valid_params
    assert_redirected_to photos_url
  end


  private

  def valid_params
    {
      photo: {
        description: 'fred'
      }
    }
  end

end
