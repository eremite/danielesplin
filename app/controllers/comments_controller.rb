class CommentsController < ApplicationController

  def create
    @comment = @user.comments.new(safe_params)
    if @comment.save
      flash.notice = 'Thank you!'
    else
      flash.alert = @comment.errors.full_messages.to_sentence
    end
    redirect_to [@comment.post, access_token: params[:access_token]]
  end

  def edit
    @comment = Comment.find(params[:id])
    deny_access unless @comment.user_id == Current.user.id || Current.user.parent?
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(safe_params)
      redirect_to @comment.post, notice: 'Comment updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.post, notice: 'Comment deleted.'
  end

  private

  def safe_params
    params.require(:comment).permit(:post_id, :body)
  end

  def authorized?
    @user = Current.user
    return true if @user.present?
    @user = User.find_by!(access_token: params[:access_token])
    return false if action_name != 'create' || @user.access_token_expires_at.past?
    true
  end

end
