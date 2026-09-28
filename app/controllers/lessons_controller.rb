class LessonsController < ApplicationController

  def index
    @lessons = Current.user.lessons.order(created_at: :asc).page(params[:page])
    @lessons = @lessons.where(dismissed_at: nil) unless params[:show_all] == 'true'
  end

  private

  def authorized?
    return true unless Rails.env.production?
    ENV['PHOTO_FRAME_IP'].to_s.split.include?(request.remote_ip)
  end

end
