class UploadBatchesController < ApplicationController

  def new
    @upload_batch = UploadBatch.new
  end

  def create
    @upload_batch = UploadBatch.new(params[:upload_batch])
    if @upload_batch.save!
      redirect_to photos_url
    else
      render :new
    end
  end

end
