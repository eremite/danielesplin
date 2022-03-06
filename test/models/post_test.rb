require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test 'valid' do
    assert posts(:base).valid?
  end

  test 'title' do
    post = posts(:base)
    post.body = "<h1>hello</h1><p>More content</p>"
    assert_equal "hello", post.title
  end

  test 'dated_title' do
    post = posts(:base)
    post.at = '2013-10-31'.to_date
    post.body = "<h1>Halloween</h1><p>it was fun</p>"
    assert_equal '10/31/2013 Halloween', post.dated_title
  end

  test 'auto_assign_photos' do
    skip
  end

end
