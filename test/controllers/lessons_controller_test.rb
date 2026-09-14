require 'test_helper'

class LessonsControllerTest < ActionDispatch::IntegrationTest

  setup do
    login(:admin)
  end

  test 'index' do
    get '/lessons'
    assert_response :success
  end

end
