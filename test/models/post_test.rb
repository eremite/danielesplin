require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test 'valid' do
    assert posts(:base).valid?
  end

  test 'dated_title' do
    now = Time.zone.now
    assert_equal 'Adventures', Post.new(title: 'Adventures', at: now).dated_title
    assert_equal now.strftime('%B %Y'), Post.new(title: nil, at: now).dated_title
  end

  test 'auto_assign_photos' do
    photo = photos(:base)
    photo.update_columns(at: Time.current, hidden: false)
    post = Post.create!(body: 'Body', at: Time.current)
    assert post.photos.include?(photo)
  end

  test 'self.tags' do
    posts(:base).tap { |e| e.update!(post_tag_list: 'first') }
    assert Post.tags.exists?(name: 'first')
  end

  test 'suggested_tags' do
    post = posts(:base).tap { |e| e.update!(post_tag_list: 'existing') }
    Post.create!(body: 'C', post_tag_list: 'suggested')
    assert_not post.suggested_tags.exists?(name: 'existing')
    assert post.suggested_tags.exists?(name: 'suggested')
  end

end
