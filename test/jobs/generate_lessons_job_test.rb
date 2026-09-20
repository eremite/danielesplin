require 'test_helper'

class GenerateLessonsJobTest < ActiveJob::TestCase

  test 'perform' do
    entry = entries(:base).tap { |e| e.update_columns(embedding: [1]) }
    user = entry.user.tap { |u| u.update_columns(role: 'father') }
    user.lessons.destroy_all
    AI.stub :ask, 'Lesson!' do
      GenerateLessonsJob.perform_now
    end
    lesson = Lesson.last
    assert_not_nil lesson
    assert_equal 'Lesson!', lesson.body
    assert_equal 'Lesson!', lesson.title
    assert_equal 'Lesson!', lesson.tone
  end

end
