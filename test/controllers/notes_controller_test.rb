require 'test_helper'

class NotesControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    @note = user.notes.create!(title: 'Title', body: 'body')
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
    Note.stub_any_instance :save, false do
      post :create, params: { note: @note.attributes }
    end
    assert_response :success
  end

  test 'create valid' do
    post :create, params: { note: @note.attributes }
    assert_response :redirect
  end

  test 'show' do
    get :show, params: { id: @note.id }
    assert_response :success
  end

  test 'edit' do
    get :edit, params: { id: @note.id }
    assert_response :success
  end

  test 'update invalid' do
    Note.stub_any_instance :update, false do
      put :update, params: { id: @note.id, note: @note.attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    Note.stub_any_instance :update, true do
      put :update, params: { id: @note.id, note: @note.attributes }
    end
    assert_redirected_to [:edit, @note]
  end

  test 'destroy' do
    delete :destroy, params: { id: @note.id }
    assert_redirected_to :notes
  end

end
