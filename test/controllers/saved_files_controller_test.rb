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
    SavedFile.stub_any_instance :save, false do
      post :create, saved_file: valid_attributes
    end
    assert_response :success
  end

  test 'create valid' do
    SavedFile.stub_any_instance :save, true do
      post :create, saved_file: valid_attributes
    end
    assert_redirected_to saved_files_url
  end

  test 'create valid json' do
    SavedFile.stub_any_instance :save, true do
      post :create, saved_file: valid_attributes, format: 'json'
    end
    assert_response :success
  end

  test 'edit' do
    get :edit, id: @saved_file.id
    assert_template :edit
  end

  test 'update invalid' do
    SavedFile.stub_any_instance :save, false do
      patch :update, id: @saved_file.id, saved_file: valid_attributes
    end
    assert_response :success
  end

  test 'update valid' do
    SavedFile.stub_any_instance :save, true do
      patch :update, id: @saved_file.id, saved_file: valid_attributes
    end
    assert_redirected_to saved_files_url
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
