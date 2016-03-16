require 'test_helper'

class NotesControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    @note = user.notes.create!(title: 'Title', body: 'body')
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
    Note.stub_any_instance :save, false do
      post :create, note: @note.attributes
    end
    assert_template :new
  end

  test 'create valid' do
    post :create, note: @note.attributes
    assert_redirected_to [:edit, assigns(:note)]
  end

  test 'show' do
    get :show, id: @note.id
    assert_template :show
  end

  test 'edit' do
    get :edit, id: @note.id
    assert_template :edit
  end

  test 'update invalid' do
    Note.stub_any_instance :update_attributes, false do
      put :update, id: @note.id, note: @note.attributes
    end
    assert_template :edit
  end

  test 'update valid' do
    Note.stub_any_instance :update_attributes, true do
      put :update, id: @note.id, note: @note.attributes
    end
    assert_redirected_to [:edit, @note]
  end

  test 'destroy' do
    delete :destroy, id: @note.id
    assert_redirected_to :notes
  end

end
