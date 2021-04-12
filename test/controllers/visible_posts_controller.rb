require 'test_helper'

class VisiblePostsControllerTest < ActionController::TestCase

  test 'index' do
    login_as(users(:base))
    get :index
    assert_response :success
  end

  test 'index rss' do
    get :index, format: 'rss'
    assert_response :success
  end

end
