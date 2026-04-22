require 'test_helper'

class PhotoFramesControllerTest < ActionDispatch::IntegrationTest

  test 'index' do
    get '/ff'
    assert_response :redirect
  end

  test 'show' do
    get "/ff/#{photos(:base).id}"
    assert_response :success
  end

end
