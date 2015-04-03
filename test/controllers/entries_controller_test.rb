require 'test_helper'

class EntriesControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    @entry = user.entries.create!(body: 'body', at: Time.zone.now)
    login_as(user)
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    Entry.stub_any_instance :save, false do
      post :create, entry: valid_attributes
    end
    assert_template :new
  end

  test 'create valid' do
    Entry.stub_any_instance :save, true do
      post :create, entry: valid_attributes
    end
    assert_redirected_to new_entry_url
  end

  test 'show' do
    get :show, id: @entry.id
    assert_template :show
  end

  test 'edit' do
    get :edit, id: @entry.id
    assert_template :edit
  end

  test 'update invalid' do
    Entry.stub_any_instance :update_attributes, false do
      put :update, id: @entry.id, entry: valid_attributes
    end
    assert_template :edit
  end

  test 'update valid' do
    Entry.stub_any_instance :update_attributes, true do
      put :update, id: @entry.id, entry: valid_attributes
    end
    assert_redirected_to entries_url
  end

  test 'destroy' do
    delete :destroy, id: @entry.id
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
