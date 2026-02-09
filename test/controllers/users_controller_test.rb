require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'index' do
    login_as(users(:admin))
    get :index
    assert_response :success
  end

  test 'new' do
    login_as(users(:admin))
    get :new
    assert_response :success
  end

  test 'create invalid' do
    login_as(users(:admin))
    User.stub_any_instance :save, false do
      post :create, params: { user: valid_attributes }
    end
    assert_response :success
  end

  test 'create valid' do
    login_as(users(:admin))
    User.stub_any_instance :save, true do
      post :create, params: { user: valid_attributes }
    end
    assert_redirected_to users_url
  end

  test 'edit' do
    login_as(users(:child))
    get :edit, params: { id: users(:child).id }
    assert_response :success
  end

  test 'update invalid' do
    login_as(users(:child))
    User.stub_any_instance :update, false do
      put :update, params: { id: users(:child).id, user: valid_attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    login_as(users(:child))
    User.stub_any_instance :update, true do
      put :update, params: { id: users(:child).id, user: valid_attributes }
    end
    assert_redirected_to edit_user_url(users(:child))
  end

  test 'destroy' do
    login_as(users(:admin))
    delete :destroy, params: { id: users(:child).id }
    assert_redirected_to users_url
  end


  private

  def valid_attributes
    {
      :name => 'Name',
      :email => 'e@mai.l',
      :password => 'secret123',
      :password_confirmation => 'secret123',
    }
  end

end
