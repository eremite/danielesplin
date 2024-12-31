class PrintBatchesController < ApplicationController

  def index
    @users = User.where(role: %w(father mother baby)).order(User.arel_table[:id].asc)
  end

  def entries
    @user = User.find(params[:user_id])
    starts_on = Time.zone.parse("#{params[:year]}-01-01")
    @entries = @user.entries.at_asc.where(at: starts_on..starts_on.end_of_year)
    @photos = Photo.where(at: starts_on.all_year).order(at: :asc).tagged_with(@user.name, on: :photo_tags)
    render :entries
  end

  def posts
    @photos_by_posts = {}
    Post.at_asc.past.where(at: Time.zone.local(params[:year]).all_year).includes(:photos).each do |post|
      @photos_by_posts[post] = post.photos.at_asc.where(id: post.photos.ids.sample((params[:count].presence || 5).to_i))
    end
    render :posts
  end

  private

  def authorized?
    current_user&.parent?
  end

end
