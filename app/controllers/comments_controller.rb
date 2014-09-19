class CommentsController < ApplicationController

  load_resource except: :create
  authorize_resource

  def index
    @comments = @comments.created_at_desc.page(params[:page])
  end

  def create
    @comment = current_user.comments.new(safe_params)
    if @comment.save
      redirect_to :posts, notice: 'Comment saved.'
    else
      render :new
    end
  end

  def update
    if @comment.update_attributes(safe_params)
      redirect_to :posts, notice: 'Comment updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to :posts, notice: 'Comment deleted.'
  end


  private

  def safe_params
    params.require(:comment).permit(:entry_id, :body)
  end

end
