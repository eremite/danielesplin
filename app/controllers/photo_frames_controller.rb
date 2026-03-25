class PhotoFramesController < ApplicationController

  def index
    next_photo = PhotoFrame.new.next_photo
    if next_photo.nil?
      redirect_to :root, alert: "No photos found in that range"
    else
      redirect_to "/ff/#{next_photo.id}"
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def authorized?
    return true unless Rails.env.production?
    ENV['PHOTO_FRAME_IP'].to_s.split.include?(request.remote_ip)
  end

end
