require 'test_helper'

class EntriesControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    @entry = user.entries.create!(body: 'body', at: Time.zone.now)
    login_as(user)
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create invalid' do
    Entry.stub_any_instance :save, false do
      post :create, params: { entry: valid_attributes }
    end
    assert_response :success
  end

  test 'create valid' do
    Entry.stub_any_instance :save, true do
      Entry.stub_any_instance :after_create_redirect_url, [:entries] do
        post :create, params: { entry: valid_attributes }
      end
    end
    assert_redirected_to :entries
  end

  test 'show' do
    get :show, params: { id: @entry.id }
    assert_response :success
  end

  test 'edit' do
    get :edit, params: { id: @entry.id }
    assert_response :success
  end

  test 'update invalid' do
    Entry.stub_any_instance :update, false do
      put :update, params: { id: @entry.id, entry: valid_attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    Entry.stub_any_instance :update, true do
      put :update, params: { id: @entry.id, entry: valid_attributes }
    end
    assert_redirected_to entries_url
  end

  test 'destroy' do
    delete :destroy, params: { id: @entry.id }
    assert_redirected_to entries_url
  end


  private

  def valid_attributes
    {
      at: Time.zone.now,
      body: 'Body',
    }
  end

end
