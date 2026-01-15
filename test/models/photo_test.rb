require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  test 'valid' do
    assert photos(:base).valid?
  end

  test "self.search" do
    assert_includes Photo.search({}), photos(:base)
  end

  test "self.order_options" do
    assert_equal %i[at_desc created_at_desc updated_at_desc], Photo.order_options.map(&:last)
  end

  test 'handle hidden' do
    photo = Photo.new(hidden: false)
    photo.post_ids = posts(:base).id
    photo.posts.build
    photo.hidden = true
    photo.valid?
    assert photo.post_ids.empty?
    assert photo.posts.empty?
  end

  test 'auto_assign_posts' do
    post = posts(:base)
    post.update_columns(created_at: Time.current)
    photo = photos(:base)
    photo.update_columns(hidden: false)
    photo.post_photos.destroy_all
    photo.save
    assert photo.posts.include?(post)
  end

  test 'self.tags' do
    photo = photos(:base).tap { |e| e.update!(photo_tag_list: 'first') }
    assert Photo.tags.exists?(name: 'first')
  end

  test 'suggested_tags' do
    photo = photos(:base).tap { |e| e.update!(photo_tag_list: 'existing') }
    second = Photo.create!(user: users(:base), photo_tag_list: 'suggested')
    assert_not photo.suggested_tags.exists?(name: 'existing')
    assert photo.suggested_tags.exists?(name: 'suggested')
  end

end
