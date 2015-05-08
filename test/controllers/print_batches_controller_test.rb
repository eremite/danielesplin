require 'test_helper'

class PrintBatchesControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'entries' do
    get :entries, :user_id => users(:admin).id, year: Time.zone.now.year
    assert_template :entries
  end

  test 'posts' do
    get :posts, year: Time.zone.now.year
    assert_template :posts
  end

end
