class PhotoBatchesController < ApplicationController

  def create
    batch = PhotoBatch.new(params.require(:photo_batch).permit(images: []).merge(user: Current.user))
    flash.alert = batch.errors.to_sentence unless batch.save && batch.errors.empty?
    redirect_to [:edit, Photo.where(description: nil).first]
  end

  private

  def safe_params
    params.require(:photo).permit!
  end

  def authorized?
    Current.user&.parent?
  end

end
