require 'test_helper'

class EntriesControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    @entry = user.entries.create!(body: 'body')
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
    Entry.any_instance.stubs(save: false)
    post :create, entry: {}
    assert_template :new
  end

  test 'create valid' do
    Entry.any_instance.stubs(save: true)
    post :create, entry: {}
    assert_redirected_to entries_url
  end

  test 'create valid with redirect' do
    Entry.any_instance.stubs(save: true)
    post :create, entry: {}, redirect_to: '/blog_posts'
    assert_redirected_to '/blog_posts'
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

  test 'update valid with redirect' do
    Entry.any_instance.stubs(save: true)
    put :update, id: @entry.id, entry: {}, redirect_to: '/blog_posts'
    assert_redirected_to '/blog_posts'
  end

  test 'destroy' do
    delete :destroy, id: @entry.id
    assert_redirected_to entries_url
  end

  test 'baby_body' do
    get :baby_body, id: @entry.id, format: :json
    assert_response :success
  end

end
