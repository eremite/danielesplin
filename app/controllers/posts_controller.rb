class PostsController < ApplicationController

  load_resource except: [:new, :create]
  authorize_resource

  def index
    current_user.try(:log, 'blog')
    begin
      @ends_on = Date.strptime(params[:ends_on].to_s, '%m/%d/%Y')
    rescue ArgumentError, TypeError
      flash[:error] = 'Invalid date' if params[:ends_on].present?
      @ends_on = Time.zone.now.to_date
    end
    @posts = Post.at_desc.published(params[:unpublished].blank?).page(params[:page])
    @posts = @posts.before(@ends_on.end_of_day) if params[:ends_on].present?
    if params[:tag].present?
      @posts = @posts.tagged_with(params[:tag], on: :post_tags)
    end
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
  end

  def update
    if @post.update_attributes(safe_params)
      redirect_to :posts, notice: 'Post saved.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to entries_url, notice: 'Post destroyed.'
  end


  private

  def safe_params
    params.permit(post: [:at, :body, :post_tag_list])[:post]
  end

end
