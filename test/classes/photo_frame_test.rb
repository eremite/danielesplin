require "test_helper"

class PhotoFrameTest < ActiveSupport::TestCase

  test "next_photo returns a photo from cache if available" do
    photo = photos(:base)
    photo.update_columns(at: 1.year.ago - 1.day)
    Photo.where.not(id: photo.id).destroy_all
    assert_equal photo.id, PhotoFrame.new.next_photo.id
  end

end
