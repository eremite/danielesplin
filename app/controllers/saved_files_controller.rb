class SavedFilesController < ApplicationController

  def index
    @saved_files = SavedFile.all
    @saved_file_category = SavedFileCategory.where(id: params[:category_id]).first
    if @saved_file_category
      @saved_files = @saved_files.where(saved_file_category_id: @saved_file_category.id)
    else
      @saved_file_categories = SavedFileCategory.name_asc
      @saved_files = @saved_files.where(saved_file_category_id: nil).created_at_desc.page(params[:page])
    end
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
          render :json => { :files => [@saved_file.to_jq_upload] }.to_json
        end
      end
    else
      render :json => { :files => [@saved_file.to_jq_upload.merge(:error => @saved_file.errors.full_messages.to_sentence)] }.to_json
    end
  end

  def edit
    @saved_file = SavedFile.find(params[:id])
  end

  def update
    @saved_file = SavedFile.find(params[:id])
    if @saved_file.update(safe_params)
      redirect_to saved_files_url, notice: 'File saved.'
    else
      render :edit
    end
  end

  def destroy
    @saved_file = SavedFile.find(params[:id])
    @saved_file.destroy
    redirect_to saved_files_url, notice: 'File deleted.'
  end

  private

  def safe_params
    params.require(:saved_file).permit!
  end

  def authorized?
    current_user&.parent?
  end

end
