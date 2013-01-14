require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    login_as(users(:base))
  end

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    Comment.any_instance.stubs(save: false)
    post :create, comment: {}
    assert_template :new
  end

  test 'create valid' do
    Comment.any_instance.stubs(save: true)
    post :create, comment: {}
    assert_redirected_to blog_posts_url
  end

  test 'edit' do
    get :edit, id: comments(:base).id
    assert_template :edit
  end

  test 'update invalid' do
    Comment.any_instance.stubs(valid?: false)
    put :update, id: comments(:base).id, comment: {}
    assert_template :edit
  end

  test 'update valid' do
    Comment.any_instance.stubs(valid?: true)
    put :update, id: comments(:base).id, comment: {}
    assert_redirected_to blog_posts_url
  end

  test 'destroy' do
    delete :destroy, id: comments(:base).id
    assert_redirected_to blog_posts_url
  end

end
