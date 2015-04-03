require 'test_helper'

class ThoughtsControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    login_as(user)
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'create invalid' do
    Thought.stub_any_instance :save, false do
      post :create, thought: valid_attributes
    end
    assert_template :edit
  end

  test 'create valid' do
    Thought.stub_any_instance :save, true do
      post :create, thought: valid_attributes
    end
    assert_redirected_to thoughts_url
  end

  test 'edit' do
    get :edit, id: thoughts(:base).id
    assert_template :edit
  end

  test 'update invalid' do
    Thought.stub_any_instance :update_attributes, false do
      put :update, id: thoughts(:base).id, thought: valid_attributes
    end
    assert_template :edit
  end

  test 'update valid' do
    Thought.stub_any_instance :update_attributes, true do
      put :update, id: thoughts(:base).id, thought: valid_attributes
    end
    assert_redirected_to thoughts_url
  end

  test 'destroy' do
    delete :destroy, id: thoughts(:base).id
    assert_redirected_to thoughts_url
  end


  private

  def valid_attributes
    {
      on: Time.zone.now.to_date,
      user_id: users(:base).id,
      body: 'Body',
    }
  end

end
