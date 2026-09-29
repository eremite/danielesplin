class LessonsController < ApplicationController

  def index
    @lessons = Current.user.lessons.order(created_at: :asc).page(params[:page])
    @lessons = @lessons.where(dismissed_at: nil) unless params[:show_all] == 'true'
  end

  private

  def authorized?
    Current.user&.parent? || Current.user&.child?
  end

end
