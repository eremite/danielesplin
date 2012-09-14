class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(safe_params)
    if @photo.save
      redirect_to photos_url
    else
      render :new
    end
  end


  private

  def safe_params
    safe_attributes = [
      :description,
    ]
    params.require(:photo).permit(*safe_attributes)
  end

end
