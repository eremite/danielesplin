require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  test 'valid' do
    assert lessons(:base).valid?
  end

  test 'dismissed?' do
    assert_not Lesson.new(dismissed_at: nil).dismissed?
    assert Lesson.new(dismissed_at: 1.day.ago).dismissed?
  end

end
