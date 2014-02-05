class SavedFilesController < ApplicationController

  load_resource except: :create
  authorize_resource

  def index
    @saved_files = @saved_files.created_at_desc.page(params[:page])
  end

  def create
    @saved_file = current_user.saved_files.new(safe_params)
    if @saved_file.save
      respond_to do |format|
        format.html do
          redirect_to saved_files_url
        end
        format.json do
          logger.debug("### #{@saved_file.to_jq_upload.inspect}") #TODO: remove debug code
          render :json => { :files => [@saved_file.to_jq_upload] }.to_json
        end
      end
    else
      render :json => { :files => [@saved_file.to_jq_upload.merge(:error => @saved_file.errors.full_messages.to_sentence)] }.to_json
    end
  end

  def destroy
    @saved_file.destroy
    redirect_to saved_files_url, notice: 'File deleted.'
  end


  private

  def safe_params
    params.require(:saved_file).permit!
  end

end
