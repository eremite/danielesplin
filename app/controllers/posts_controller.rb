class PostsController < ApplicationController

  def index
    current_user.try(:log, 'blog')
    current_user.try(:touch, :viewed_blog_at)
    @ends_on = Date.parse(params[:ends_on] || Date.current.to_s)
    @past_posts = Post.at_desc.past.page(params[:page])
    @past_posts = @past_posts.before(@ends_on.end_of_day) if params[:ends_on].present?
    if params[:term].present?
      @past_posts = @past_posts.where(Post.arel_table[:body].matches("%#{params[:term].to_s.downcase}%"))
    end
    if params[:tag].present?
      @past_posts = @past_posts.tagged_with(params[:tag], on: :post_tags)
    end
    @future_posts = Post.at_desc.future
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
    current_user&.parent?
  end

end
