class LessonsController < ApplicationController

  def index
    @lessons = Current.user.lessons.page(params[:page])
  end

  private

  def authorized?
    Current.user&.parent? || Current.user&.child?
  end

end
