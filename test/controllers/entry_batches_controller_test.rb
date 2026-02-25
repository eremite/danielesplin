require 'test_helper'

class EntryBatchesControllerTest < ActionDispatch::IntegrationTest

  setup do
    login(:admin)
  end

  test 'new' do
    get '/entry_batches/new'
    assert_response :success
  end

  test 'create' do
    post '/entry_batches', params: { entry_batch: { entry_params_by_user_id: { users(:child).id => { body: "Body" } } } }
    assert_redirected_to '/entries?on_this_day=1'
  end

end
