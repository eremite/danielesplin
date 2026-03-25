require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest

  setup do
    @photo = photos(:base)
    login(:admin)
  end

  test 'index' do
    get '/photos'
    assert_response :success
  end

  test 'edit' do
    get "/photos/#{@photo.id}/edit"
    assert_response :success
  end

  test 'update invalid' do
    Photo.stub_any_instance :update, false do
      put "/photos/#{@photo.id}", params: { photo: valid_attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    Photo.stub_any_instance :update, true do
      put "/photos/#{@photo.id}", params: { photo: valid_attributes }
    end
    assert_redirected_to photos_url
  end

  test 'update valid with redirect' do
    Photo.stub_any_instance :update, true do
      put "/photos/#{@photo.id}", params: { photo: valid_attributes, redirect_to: '/' }
    end
    assert_redirected_to '/'
  end

  test 'destroy' do
    delete "/photos/#{@photo.id}"
    assert_redirected_to '/photos'
  end

  private

  def valid_attributes
    {
      at: Time.zone.now,
      description: 'Description',
    }
  end

end
