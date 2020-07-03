class PostPhotosController < ApplicationController

  def create
    post_photo = PostPhoto.create(safe_params)
    redirect_to [:edit, post_photo.post]
  end

  def destroy
    post_photo = PostPhoto.find(params[:id])
    post_photo.destroy
    redirect_to [:edit, post_photo.post]
  end


  private

  def safe_params
    params.require(:post_photo).permit!
  end

  def authorized?
    current_user&.parent?
  end

end
