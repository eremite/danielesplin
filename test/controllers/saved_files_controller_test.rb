require 'test_helper'

class SavedFilesControllerTest < ActionController::TestCase

  def setup
    @saved_file = saved_files(:base)
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
    SavedFile.any_instance.stubs(save: false)
    post :create, saved_file: valid_attributes
    assert_response :success
  end

  test 'create valid' do
    SavedFile.any_instance.stubs(save: true)
    post :create, saved_file: valid_attributes
    assert_redirected_to saved_files_url
  end

  test 'create valid json' do
    SavedFile.any_instance.stubs(save: true)
    post :create, saved_file: valid_attributes, format: 'json'
    assert_response :success
  end

  test 'destroy' do
    delete :destroy, id: @saved_file.id
    assert_redirected_to saved_files_url
  end


  private

  def valid_attributes
    {
      description: 'Description',
    }
  end

end
