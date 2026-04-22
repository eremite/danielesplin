require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  test 'index' do
    get '/pages'
    assert_response :success
  end

end
