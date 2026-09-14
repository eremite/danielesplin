require 'test_helper'

class LessonDismissalsControllerTest < ActionDispatch::IntegrationTest

  setup do
    user = login(:admin)
    @lesson = lessons(:base).tap { |l| l.update_columns(user_id: user.id) }
  end

  test 'create' do
    post "/lessons/#{@lesson.id}/lesson_dismissals"
    assert_redirected_to :lessons
  end

end
