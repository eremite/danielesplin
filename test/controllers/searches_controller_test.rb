require 'test_helper'

class SearchesControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    login_as(user)
  end

  test 'index' do
    get :index
    assert_template :index
  end

end
