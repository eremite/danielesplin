class BlogPostsController < ApplicationController

  authorize_resource :class => false

  def index
    @entries = Entry.public.at_desc.page(params[:page])
  end

  def new
    @entry = Entry.public.new
    @entry.at = Time.zone.now
  end

  def create
    @entry = current_user.entries.public.new(params[:entry])
    if @entry.save
      redirect_to blog_posts_url, notice: 'Blog Post saved.'
    else
      render :new
    end
  end

end
