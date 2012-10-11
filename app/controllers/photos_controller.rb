class PhotosController < ApplicationController

  load_and_authorize_resource

  def create
    @photo = current_user.photos.new(params[:photo])
    if @photo.save
      redirect_to photos_url
    else
      render :new
    end
  end

  def update
    if @photo.update_attributes(params[:photo])
      redirect_to photos_url
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_url, notice: 'Photo destroyed.'
  end

end
