class VisiblePostsController < ApplicationController

  def index
    current_user.try(:log, 'blog')
    current_user.try(:touch, :viewed_blog_at)
    @posts = Post.at_desc.past.page(params[:page])
  end

  private

  def authorized?
    return true if params[:action] == "index" && params[:format] == "rss"
    current_user.present?
  end

end
