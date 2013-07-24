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
    assert_redirected_to new_photo_url
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
    Photo.any_instance.stubs(valid?: false)
    put :update, id: @photo.id, photo: {}
    assert_template :edit
  end

  test 'update valid' do
    Photo.any_instance.stubs(valid?: true)
    put :update, id: @photo.id, photo: {}
    assert_redirected_to photos_url
  end

  test 'update valid with redirect' do
    Photo.any_instance.stubs(valid?: true)
    put :update, id: @photo.id, photo: {}, redirect_to: '/'
    assert_redirected_to '/'
  end

  test 'destroy' do
    delete :destroy, id: @photo.id
    assert_redirected_to photos_url
  end

end
