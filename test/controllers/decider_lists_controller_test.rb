require 'test_helper'

class DeciderListsControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'create invalid' do
    post :create, params: { decider_list: { name: "" } }
    assert_redirected_to :decider_lists
  end

  test 'create valid' do
    post :create, params: { decider_list: { name: "Present" } }
    assert_redirected_to DeciderList.last
  end

  test 'show' do
    get :show, params: { id: decider_lists(:base).id }
    assert_response :success
  end

  test 'destroy' do
    get :destroy, params: { id: decider_lists(:base).id }
    assert_redirected_to :decider_lists
  end

end
