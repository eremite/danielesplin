require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'index' do
    login_as(users(:admin))
    get :index
    assert_template :index
  end

  test 'new' do
    login_as(users(:admin))
    get :new
    assert_template :new
  end

  test 'create invalid' do
    login_as(users(:admin))
    User.stub_any_instance :save, false do
      post :create, user: valid_attributes
    end
    assert_template :new
  end

  test 'create valid' do
    login_as(users(:admin))
    User.stub_any_instance :save, true do
      post :create, user: valid_attributes
    end
    assert_redirected_to users_url
  end

  test 'edit' do
    login_as(users(:base))
    get :edit, id: users(:base).id
    assert_template :edit
  end

  test 'update invalid' do
    login_as(users(:base))
    User.stub_any_instance :update_attributes, false do
      put :update, id: users(:base).id, user: valid_attributes
    end
    assert_template :edit
  end

  test 'update valid' do
    login_as(users(:base))
    User.stub_any_instance :update_attributes, true do
      put :update, id: users(:base).id, user: valid_attributes
    end
    assert_redirected_to edit_user_url(users(:base))
  end

  test 'destroy' do
    login_as(users(:admin))
    delete :destroy, id: users(:base).id
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
