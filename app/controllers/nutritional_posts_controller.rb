class NutritionalPostsController < ApplicationController

  layout 'nutritionalbites'

  def index
    @nutritional_posts = NutritionalPost.published.created_at_desc
  end

  def show
    @nutritional_post = NutritionalPost.published.where(slug: params[:id]).first!
  end

end
