class PublicNutritionalPostsController < ApplicationController

  layout 'nutritionalbites'

  def index
    @nutritional_posts = NutritionalPost.published(true).created_at_desc
  end

  def show
    @nutritional_post = NutritionalPost.published(true).where(slug: params[:id]).first!
  end

end
