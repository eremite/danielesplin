require 'test_helper'

class SavedFileCategoriesControllerTest < ActionController::TestCase

  def setup
    @saved_file_category = saved_file_categories(:base)
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'create invalid' do
    SavedFileCategory.stub_any_instance :save, false do
      post :create, params: { saved_file_category: valid_attributes }
    end
    assert_response :success
  end

  test 'create valid' do
    SavedFileCategory.stub_any_instance :save, true do
      post :create, params: { saved_file_category: valid_attributes }
    end
    assert_redirected_to saved_file_categories_url
  end

  test 'update invalid' do
    SavedFileCategory.stub_any_instance :save, false do
      patch :update, params: { id: @saved_file_category.id, saved_file_category: valid_attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    SavedFileCategory.stub_any_instance :save, true do
      patch :update, params: { id: @saved_file_category.id, saved_file_category: valid_attributes }
    end
    assert_redirected_to saved_file_categories_url
  end

  test 'destroy' do
    delete :destroy, params: { id: @saved_file_category.id }
    assert_redirected_to saved_file_categories_url
  end


  private

  def valid_attributes
    {
      name: 'Category',
    }
  end

end
