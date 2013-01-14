class CommentsController < ApplicationController

  load_and_authorize_resource

  def create
    @comment = current_user.comments.new(params[:comment])
    if @comment.save
      redirect_to blog_posts_url, notice: 'Comment saved.'
    else
      render :new
    end
  end

  def update
    if @comment.update_attributes(params[:comment])
      redirect_to blog_posts_url, notice: 'Comment updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to blog_posts_url, notice: 'Comment deleted.'
  end

end
