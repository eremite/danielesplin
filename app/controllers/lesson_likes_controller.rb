class LessonLikesController < ApplicationController

  def create
    Current.user.lessons.find(params.expect(:lesson_id)).touch(:liked_at)
    redirect_to :lessons
  end

  private

  def authorized?
    Current.user&.parent? || Current.user&.child?
  end

end
