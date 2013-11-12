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

  test 'old_new' do
    get :old_new
    assert_template :old_new
  end

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    Photo.any_instance.stubs(save: false)
    post :create, photo: valid_attributes
    assert_template :new
  end

  test 'create valid' do
    Photo.any_instance.stubs(save: true)
    post :create, photo: valid_attributes
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
    Photo.any_instance.stubs(update_attributes: false)
    put :update, id: @photo.id, photo: valid_attributes
    assert_template :edit
  end

  test 'update valid' do
    Photo.any_instance.stubs(update_attributes: true)
    put :update, id: @photo.id, photo: valid_attributes
    assert_redirected_to photos_url
  end

  test 'update valid with redirect' do
    Photo.any_instance.stubs(update_attributes: true)
    put :update, id: @photo.id, photo: valid_attributes, redirect_to: '/'
    assert_redirected_to '/'
  end

  test 'destroy' do
    delete :destroy, id: @photo.id
    assert_redirected_to photos_url
  end

  test 'reprocess' do
    put :reprocess, id: @photo.id
    assert_redirected_to @photo
  end


  private

  def valid_attributes
    {
      at: Time.zone.now,
      description: 'Description',
    }
  end

end
