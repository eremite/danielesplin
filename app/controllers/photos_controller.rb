class PhotosController < ApplicationController

  load_resource except: :create
  authorize_resource

  def index
    @photos = @photos.created_at_desc.page(params[:page])
  end

  def create
    @photo = current_user.photos.new(safe_params)
    if @photo.save
      redirect_to new_photo_url, notice: 'Photo saved.'
    else
      render :new
    end
  end

  def update
    if @photo.update_attributes(safe_params)
      redirect_to params[:redirect_to].presence || photos_url, notice: 'Photo saved.'
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_url, notice: 'Photo destroyed.'
  end

  def reprocess
    @photo.reprocess
    redirect_to @photo
  end


  private

  def safe_params
    params.require(:photo).permit(:at, :description, :image, :entry_id, :hidden)
  end

end
