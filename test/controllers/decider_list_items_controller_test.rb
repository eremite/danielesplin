require 'test_helper'

class DeciderListsControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'new' do
    get :new
    assert_response :success
  end

end
