require 'test_helper'

class ThoughtsControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    login_as(user)
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'create invalid' do
    Thought.any_instance.stubs(save: false)
    post :create, thought: {}
    assert_template :index
  end

  test 'create valid' do
    Thought.any_instance.stubs(save: true)
    post :create, thought: {}
    assert_redirected_to thoughts_url
  end

  test 'destroy' do
    delete :destroy, id: thoughts(:base).id
    assert_redirected_to thoughts_url
  end

end
