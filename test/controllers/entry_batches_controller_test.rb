require 'test_helper'

class EntryBatchesControllerTest < ActionController::TestCase

  setup do
    login_as(users(:admin))
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create' do
    put :create, params: { entry_batch: { entry_params_by_user_id: { users(:child).id => { body: "Body" } } } }
    assert_redirected_to [:entries, { on_this_day: 1 }]
  end

end
