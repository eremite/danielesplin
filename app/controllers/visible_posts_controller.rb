class VisiblePostsController < ApplicationController

  def index
    @posts = Post.at_desc.past.page(params[:page])
  end

  private

  def authorized?
    true
  end

end
