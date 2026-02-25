class PhotosController < ApplicationController

  def index
    @photos = Photo.search(params)
  end

  def show
    @photo = Photo.find_by(id: params[:id])
    redirect_to :photos, alert: "No photos found in that range" if @photo.nil?
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(safe_params)
      next_photo = Photo.where(description: nil).first
      redirect_to next_photo.present? ? [:edit, next_photo] : params[:redirect_to] || :photos
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
    Current.user&.parent? || Current.user&.child?
  end

end
