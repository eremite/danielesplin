class PostsController < ApplicationController

  def index
    redirect_to Post.at_desc.past.first
  end

  def new
    @post = Post.new(safe_params)
    @post.at ||= Time.zone.now
  end

  def create
    @post = Post.new(safe_params)
    if @post.save
      redirect_to :posts, notice: 'Blog Post saved.'
    else
      render :new
    end
  end

  def show
    current_user.log('blog')
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(safe_params)
      redirect_to :posts, notice: 'Post saved.'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :posts, notice: 'Post destroyed.'
  end

  private

  def safe_params
    params.permit(post: [:at, :body, :post_tag_list])[:post]
  end

  def authorized?
    return true if current_user.present? && action_name == "index"
    current_user&.parent?
  end

end
