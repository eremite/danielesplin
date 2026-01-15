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
    photo = photos(:base)
    photo.update_columns(at: Time.current, hidden: false)
    post = Post.create!(body: "Body", at: Time.current)
    assert post.photos.include?(photo)
  end


  test 'self.tags' do
    post = posts(:base).tap { |e| e.update!(post_tag_list: 'first') }
    assert Post.tags.exists?(name: 'first')
  end

  test 'suggested_tags' do
    post = posts(:base).tap { |e| e.update!(post_tag_list: 'existing') }
    second = Post.create!(body: 'C', post_tag_list: 'suggested')
    assert_not post.suggested_tags.exists?(name: 'existing')
    assert post.suggested_tags.exists?(name: 'suggested')
  end

end
