class PhotosController < ApplicationController

  load_and_authorize_resource

  def index
    @photos = @photos.at_desc.page(params[:page])
  end

  def create
    @photo = current_user.photos.new(params[:photo])
    if @photo.save
      redirect_to new_photo_url, notice: 'Photo saved.'
    else
      render :new
    end
  end

  def update
    if @photo.update_attributes(params[:photo])
      redirect_to photos_url, notice: 'Photo saved.'
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_url, notice: 'Photo destroyed.'
  end

end
