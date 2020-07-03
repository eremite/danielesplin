class PhotosController < ApplicationController

  def index
    @photos = Photo.created_at_desc.page(params[:page])
    if params[:tag].present?
      @photos = @photos.tagged_with(params[:tag], on: :photo_tags)
    end
  end

  def new
    @photos = Photo.where(created_at: Time.zone.today.beginning_of_day..Time.zone.tomorrow.end_of_day)
  end

  def create
    @photo = current_user.photos.new(safe_params)
    if @photo.save
      respond_to do |format|
        format.html do
          redirect_to :photos
        end
        format.json do
          render :json => { :files => [@photo.to_jq_upload] }.to_json
        end
      end
    else
      render :json => { :files => [@photo.to_jq_upload.merge(:error => @photo.errors.full_messages.to_sentence)] }.to_json
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(safe_params)
      redirect_to params[:redirect_to].presence || photos_url, notice: 'Photo saved.'
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
