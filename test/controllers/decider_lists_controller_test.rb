require 'test_helper'

class DeciderListsControllerTest < ActionDispatch::IntegrationTest

  setup do
    login(:admin)
  end

  test 'index' do
    get '/decider_lists'
    assert_response :success
  end

  test 'create invalid' do
    post '/decider_lists', params: { decider_list: { name: "" } }
    assert_redirected_to decider_lists_path
  end

  test 'create valid' do
    post '/decider_lists', params: { decider_list: { name: "Present" } }
    assert_redirected_to decider_list_path(DeciderList.last)
  end

  test 'show' do
    get "/decider_lists/#{decider_lists(:base).id}"
    assert_response :success
  end

  test 'destroy' do
    delete "/decider_lists/#{decider_lists(:base).id}"
    assert_redirected_to '/decider_lists'
  end

end
