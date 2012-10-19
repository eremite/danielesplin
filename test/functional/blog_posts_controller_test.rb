require 'test_helper'

class BlogPostsControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
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
    assert_redirected_to blog_posts_url
  end

end
