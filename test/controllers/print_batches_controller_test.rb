require 'test_helper'

class PrintBatchesControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'entries' do
    get :entries, params: { user_id: users(:admin).id, year: Time.zone.now.year }
    assert_response :success
  end

  test 'posts' do
    get :posts, params: { year: Time.zone.now.year }
    assert_response :success
  end

end
