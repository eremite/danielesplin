class PhotosController < ApplicationController
  def index
    @search = PhotoSearch.new(search_params).load
  end

  def edit
    @photo = Photo.find(params[:id])
    @redirect_path = url_from(params[:redirect_to]) || :photos
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

  def search_params
    params.fetch(:photo_search, {}).permit(
      :media, :order, :ends_on, :term, :tag, :page, :photos, :unblogged, :not_hidden, :nondescript
    )
  end

  def safe_params
    params.expect(photo: %i[at hidden description photo_tag_list] + [{ post_ids: [] }])
  end

  def authorized?
    Current.user&.parent? || Current.user&.child?
  end
end
