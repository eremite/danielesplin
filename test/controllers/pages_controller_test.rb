require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  test 'index' do
    get :index
    assert_response :success
  end

end
