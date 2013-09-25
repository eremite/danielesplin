require 'test_helper'

class BlogPostsControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'index rss' do
    logout
    get :index, format: 'rss'
    assert_template :index
  end

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    Entry.any_instance.stubs(save: false)
    post :create, entry: valid_attributes
    assert_template :new
  end

  test 'create valid' do
    Entry.any_instance.stubs(save: true)
    post :create, entry: valid_attributes
    assert_redirected_to blog_posts_url
  end


  private

  def valid_attributes
    {
      at: Time.zone.now,
      body: 'Body',
    }
  end

end
