require 'test_helper'

class DeciderListPickerControllerTest < ActionDispatch::IntegrationTest

  test 'index' do
    get '/pick'
    assert_response :success
  end

  test 'new' do
    get "/pick/#{decider_lists(:base).id}"
    assert_response :success
  end

  test 'create' do
    post "/pick/#{decider_lists(:base).id}"
    assert_response :success
  end

end
