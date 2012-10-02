require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  test 'index' do
    get :index
    assert_template :index
  end

end
