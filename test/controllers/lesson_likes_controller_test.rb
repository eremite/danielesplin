require 'test_helper'

class LessonLikesControllerTest < ActionDispatch::IntegrationTest

  setup do
    user = login(:admin)
    @lesson = lessons(:base).tap { |l| l.update_columns(user_id: user.id) }
  end

  test 'create' do
    post "/lessons/#{@lesson.id}/lesson_likes"
    assert_redirected_to :lessons
  end

end
