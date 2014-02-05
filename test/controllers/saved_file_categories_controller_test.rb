require 'test_helper'

class SavedFileCategoriesControllerTest < ActionController::TestCase

  def setup
    @saved_file_category = saved_file_categories(:base)
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'create invalid' do
    SavedFileCategory.any_instance.stubs(save: false)
    post :create, saved_file_category: valid_attributes
    assert_response :success
  end

  test 'create valid' do
    SavedFileCategory.any_instance.stubs(save: true)
    post :create, saved_file_category: valid_attributes
    assert_redirected_to saved_file_categories_url
  end

  test 'update invalid' do
    SavedFileCategory.any_instance.stubs(save: false)
    patch :update, id: @saved_file_category.id, saved_file_category: valid_attributes
    assert_response :success
  end

  test 'update valid' do
    SavedFileCategory.any_instance.stubs(save: true)
    patch :update, id: @saved_file_category.id, saved_file_category: valid_attributes
    assert_redirected_to saved_file_categories_url
  end

  test 'destroy' do
    delete :destroy, id: @saved_file_category.id
    assert_redirected_to saved_file_categories_url
  end


  private

  def valid_attributes
    {
      name: 'Category',
    }
  end

end
