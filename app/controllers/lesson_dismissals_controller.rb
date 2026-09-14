class LessonDismissalsController < ApplicationController

  def create
    Current.user.lessons.find(params.expect(:lesson_id)).touch(:dismissed_at)
    redirect_to :lessons
  end

  private

  def authorized?
    Current.user&.parent? || Current.user&.child?
  end

end
