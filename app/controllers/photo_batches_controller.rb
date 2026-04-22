class PhotoBatchesController < ApplicationController

  def create
    batch = PhotoBatch.new(params.expect(photo_batch: [{ images: [] }]).merge(user: Current.user))
    flash.alert = batch.errors.to_sentence unless batch.save && batch.errors.empty?
    redirect_to [:edit, Photo.where(description: nil).first]
  end

  private

  def authorized?
    Current.user&.parent?
  end

end
