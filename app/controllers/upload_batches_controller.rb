class UploadBatchesController < ApplicationController

  def new
    @upload_batch = UploadBatch.new
  end

  def create
    @upload_batch = UploadBatch.new(safe_params)
    @upload_batch.user = current_user
    if @upload_batch.save!
      redirect_to new_upload_batch_url
    else
      render :new
    end
  end


  private

  def safe_params
    params.require(:upload_batch).permit(:description, :images)
  end

end
