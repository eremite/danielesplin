class PhotosController < ApplicationController

  load_and_authorize_resource

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(params[:photo])
    if @photo.save
      redirect_to photos_url
    else
      render :new
    end
  end

end
