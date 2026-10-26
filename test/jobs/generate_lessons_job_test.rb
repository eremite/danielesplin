require 'test_helper'

class GenerateLessonsJobTest < ActiveJob::TestCase

  test 'perform creates random lesson' do
    user = users(:base).tap { |u| u.update_columns(role: 'father') }
    user.lessons.destroy_all
    AI.stub :ask, 'Lesson!' do
      GenerateLessonsJob.perform_now
    end
    lesson = Lesson.last
    assert_not_nil lesson
    assert_equal 'Lesson!', lesson.body
    assert_equal 'Lesson!', lesson.title
  end

  test 'perform creates liked lesson' do
    liked_lesson = lessons(:base).tap { |l| l.update_columns(liked_at: 1.day.ago, question: nil) }
    liked_lesson.user.tap { |u| u.update_columns(role: 'father') }
    AI.stub :ask, 'Lesson!' do
      GenerateLessonsJob.perform_now
    end
    lesson = Lesson.last
    assert_not_nil lesson
    assert_equal 'Lesson!', lesson.body
    assert_equal 'Lesson!', lesson.title
    assert_nil liked_lesson.reload.liked_at
  end

  test 'perform answers question' do
    questionable_lesson = lessons(:base).tap { |l| l.update_columns(question: 'Why?', liked_at: nil) }
    questionable_lesson.user.tap { |u| u.update_columns(role: 'father') }
    AI.stub :ask, 'Lesson!' do
      GenerateLessonsJob.perform_now
    end
    lesson = Lesson.last
    assert_not_nil lesson
    assert_equal 'Lesson!', lesson.body
    assert_equal 'Lesson!', lesson.title
  end

end
