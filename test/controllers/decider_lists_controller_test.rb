require 'test_helper'

class DeciderListsControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'show' do
    get :show, params: { id: decider_lists(:base) }
    assert_response :success
  end

end
