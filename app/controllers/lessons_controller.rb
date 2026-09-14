class LessonsController < ApplicationController

  def index
    @lessons = Current.user.lessons.where(dismissed_at: nil).order(created_at: :asc).page(params[:page])
  end

  private

  def authorized?
    Current.user&.parent? || Current.user&.child?
  end

end
