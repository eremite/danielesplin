require 'test_helper'

class DeciderListPickerControllerTest < ActionController::TestCase

  test 'index' do
    get :index
    assert_response :success
  end

  test 'new' do
    get :new, params: { id: decider_lists(:base).id }
    assert_response :success
  end

  test 'create' do
    post :create, params: { id: decider_lists(:base).id }
    assert_response :success
  end

end
