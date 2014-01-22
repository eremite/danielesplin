class BlogPostsController < ApplicationController

  authorize_resource :class => false

  def index
    @entries = Entry.public.at_desc.published(params[:unpublished].blank?).page(params[:page]).per(7)
  end

  def new
    @entry = Entry.public.new(safe_params)
    @entry.at ||= Time.zone.now
  end

  def create
    @entry = current_user.entries.public.new(safe_params)
    if @entry.save
      redirect_to blog_posts_url, notice: 'Blog Post saved.'
    else
      render :new
    end
  end


  private

  def safe_params
    params.permit(entry: [:at, :body])[:entry]
  end

end
