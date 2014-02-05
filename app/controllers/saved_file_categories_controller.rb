class SavedFileCategoriesController < ApplicationController

  load_resource except: :create
  authorize_resource

  def index
    @saved_file_categories = SavedFileCategory.name_asc
    @saved_file_category = SavedFileCategory.new
  end

  def create
    @saved_file_category = SavedFileCategory.new(safe_params)
    if @saved_file_category.save
      redirect_to saved_file_categories_url
    else
      @saved_file_categories = SavedFileCategory.name_asc
      render :index
    end
  end

  def update
    if @saved_file_category.update_attributes(safe_params)
      redirect_to saved_file_categories_url
    else
      @saved_file_categories = SavedFileCategory.name_asc
      render :index
    end
  end

  def destroy
    @saved_file_category.destroy
    redirect_to saved_file_categories_url, notice: 'Category deleted.'
  end


  private

  def safe_params
    params.require(:saved_file_category).permit!
  end

end
