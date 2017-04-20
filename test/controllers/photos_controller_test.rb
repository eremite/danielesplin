require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

  def setup
    @photo = photos(:base)
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'create invalid' do
    Photo.stub_any_instance :save, false do
      post :create, photo: valid_attributes, format: :json
    end
    assert_response :success
  end

  test 'create valid json' do
    Photo.stub_any_instance :save, true do
      post :create, photo: valid_attributes, format: :json
    end
    assert_response :success
  end

  test 'show' do
    get :show, id: @photo.id
    assert_template :show
  end

  test 'edit' do
    get :edit, id: @photo.id
    assert_template :edit
  end

  test 'update invalid' do
    Photo.stub_any_instance :update_attributes, false do
      put :update, id: @photo.id, photo: valid_attributes
    end
    assert_template :edit
  end

  test 'update valid' do
    Photo.stub_any_instance :update_attributes, true do
      put :update, id: @photo.id, photo: valid_attributes
    end
    assert_redirected_to photos_url
  end

  test 'update valid with redirect' do
    Photo.stub_any_instance :update_attributes, true do
      put :update, id: @photo.id, photo: valid_attributes, redirect_to: '/'
    end
    assert_redirected_to '/'
  end

  test 'destroy' do
    delete :destroy, id: @photo.id
    assert_redirected_to photos_url
  end


  private

  def valid_attributes
    {
      at: Time.zone.now,
      description: 'Description',
    }
  end

end
