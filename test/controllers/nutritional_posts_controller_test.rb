require 'test_helper'

class NutritionalPostsControllerTest < ActionController::TestCase

  test 'index' do
    get :index
    assert_template :index
  end

end
