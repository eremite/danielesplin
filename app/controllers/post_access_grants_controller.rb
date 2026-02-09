class PostAccessGrantsController < ApplicationController

  def create
    access_grant = PostAccessGrant.new(safe_params).load!
    redirect_to access_grant.mailto, allow_other_host: true
  end

  private

  def safe_params
    params.require(:post_access_grant).permit(:user_id, :post_id).merge(url: request.base_url)
  end

  def authorized?
    Current.user&.parent?
  end

end
