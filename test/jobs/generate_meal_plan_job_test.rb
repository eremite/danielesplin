require 'test_helper'

class GenerateMealPlanJobTest < ActiveJob::TestCase

  test 'perform' do
    entry = entries(:base).tap { |e| e.update!(body: 'Meal plan for', entry_tag_list: 'ai') }
    user = entry.user.tap { |u| u.update_columns(role: 'father') }
    user.lessons.destroy_all
    AI.stub :ask, 'Pizza' do
      GenerateMealPlanJob.perform_now
    end
    lesson = user.reload.lessons.last
    assert_not_nil lesson
    assert_equal 'Pizza', lesson.body
    assert lesson.title.starts_with?('Meal plan for')
  end

end
