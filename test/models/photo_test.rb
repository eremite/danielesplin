require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  test 'valid' do
    assert photos(:base).valid?
  end

  test 'handle hidden' do
    skip
  end

  test 'auto_assign_entries' do
    skip
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
