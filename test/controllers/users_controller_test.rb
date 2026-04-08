require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    login(:admin)
    get '/users'
    assert_response :success
  end

  test 'new' do
    login(:admin)
    get '/users/new'
    assert_response :success
  end

  test 'create invalid' do
    login(:admin)
    User.stub_any_instance :save, false do
      post '/users', params: { user: valid_attributes }
    end
    assert_response :unprocessable_entity
  end

  test 'create valid' do
    login(:admin)
    User.stub_any_instance :save, true do
      post '/users', params: { user: valid_attributes }
    end
    assert_redirected_to '/users'
  end

  test 'edit' do
    login(:child)
    get "/users/#{users(:child).id}/edit"
    assert_response :success
  end

  test 'update invalid' do
    login(:child)
    User.stub_any_instance :update, false do
      put "/users/#{users(:child).id}", params: { user: valid_attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    login(:child)
    User.stub_any_instance :update, true do
      put "/users/#{users(:child).id}", params: { user: valid_attributes }
    end
    assert_redirected_to "/users/#{users(:child).id}/edit"
  end

  test 'destroy' do
    login(:admin)
    delete "/users/#{users(:child).id}"
    assert_redirected_to '/users'
  end

  private

  def valid_attributes
    {
      name: 'Name',
      email: 'e@mai.l',
      password: 'secret123',
      password_confirmation: 'secret123'
    }
  end
end
