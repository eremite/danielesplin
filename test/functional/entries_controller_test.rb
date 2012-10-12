require 'test_helper'

class EntriesControllerTest < ActionController::TestCase

  def setup
    @entry = entries(:base)
    login_as(@entry.user)
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
    Entry.any_instance.stubs(save: false)
    post :create, entry: {}
    assert_template :new
  end

  test 'create valid' do
    Entry.any_instance.stubs(save: true)
    post :create, entry: {}
    assert_redirected_to entries_url
  end

  test 'edit' do
    get :edit, id: @entry.id
    assert_template :edit
  end

  test 'update invalid' do
    Entry.any_instance.stubs(valid?: false)
    put :update, id: @entry.id, entry: {}
    assert_template :edit
  end

  test 'update valid' do
    Entry.any_instance.stubs(valid?: true)
    put :update, id: @entry.id, entry: {}
    assert_redirected_to entries_url
  end

  test 'destroy' do
    delete :destroy, id: @entry.id
    assert_redirected_to entries_url
  end

end
