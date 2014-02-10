class PhotosController < ApplicationController

  load_resource except: :create
  authorize_resource

  def index
    @photos = @photos.created_at_desc.page(params[:page])
  end

  def new
    @photos = Photo.where(created_at: Time.zone.today.beginning_of_day..Time.zone.tomorrow.end_of_day)
  end

  def old_new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(safe_params)
    @photo.skip_versioning = '1'
    if @photo.save
      respond_to do |format|
        format.html do
          redirect_to old_new_photos_url
        end
        format.json do
          render :json => { :files => [@photo.to_jq_upload] }.to_json
        end
      end
    else
      render :json => { :files => [@photo.to_jq_upload.merge(:error => @photo.errors.full_messages.to_sentence)] }.to_json
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
    @photo.process
    redirect_to @photo
  end


  private

  def safe_params
    params.require(:photo).permit!
  end

end
