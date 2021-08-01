class CommentsController < ApplicationController

  before_action :verify_authorized

  def create
    @comment = current_user.comments.new(safe_params)
    if @comment.save
      redirect_to :visible_posts, notice: 'Comment saved.'
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    deny_access unless @comment.user_id == current_user.id || current_user.parent?
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(safe_params)
      redirect_to :visible_posts, notice: 'Comment updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :visible_posts, notice: 'Comment deleted.'
  end

  private

  def safe_params
    params.require(:comment).permit(:post_id, :body)
  end

  def authorized?
    current_user.present?
  end

end
