class NutritionalPostsController < ApplicationController

  def index
    @nutritional_posts = NutritionalPost.created_at_desc
    authorize! :index, NutritionalPost
  end

  def show
    @nutritional_post = NutritionalPost.find(params[:id])
    authorize! :show, @nutritional_post
  end

  def new
    @nutritional_post = NutritionalPost.new
    authorize! :new, @nutritional_post
  end

  def create
    @nutritional_post = NutritionalPost.new(safe_params)
    authorize! :create, @nutritional_post
    if @nutritional_post.save
      redirect_to nutritional_posts_url, notice: 'Post saved.'
    else
      render :new
    end
  end

  def edit
    @nutritional_post = NutritionalPost.find(params[:id])
    authorize! :edit, @nutritional_post
  end

  def update
    @nutritional_post = NutritionalPost.find(params[:id])
    authorize! :update, @nutritional_post
    if @nutritional_post.update_attributes(safe_params)
      redirect_to nutritional_posts_url, notice: 'Post updated.'
    else
      render :edit
    end
  end

  def destroy
    @nutritional_post = NutritionalPost.find(params[:id])
    authorize! :destroy, @nutritional_post
    @nutritional_post.destroy
    redirect_to nutritional_posts_url, notice: 'Post deleted.'
  end

  private

  def safe_params
    params.require(:nutritional_post).permit(:published, :title, :bite, :full_plate)
  end

end
