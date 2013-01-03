class CommentsController < ApplicationController

  load_and_authorize_resource

  def create
    @comment = current_user.comments.new(params[:comment])
    if @comment.save
      redirect_to blog_posts_url, notice: 'Comment saved.'
    else
      redirect_to blog_posts_url, alert: "Comment not saved: #{@comment.errors.full_messages.to_sentence}"
    end
  end

end
