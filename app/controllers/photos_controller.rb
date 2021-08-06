class PhotosController < ApplicationController

  def index
    @photos = Photo.created_at_desc.page(params[:page]).per(100)
    if params[:tag].present?
      @photos = @photos.tagged_with(params[:tag], on: :photo_tags)
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(safe_params)
      next_photo = Photo.where(description: nil).first
      redirect_to next_photo.present? ? [:edit, next_photo] : :photos
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_url, notice: 'Photo destroyed.'
  end

  private

  def safe_params
    params.require(:photo).permit!
  end

  def authorized?
    current_user&.parent?
  end

end
