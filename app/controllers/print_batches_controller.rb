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
    starts_on = Time.zone.parse("#{params[:year]}-01-01")
    @posts = Post.at_asc.past.where(at: starts_on..starts_on.end_of_year)
    render :posts, layout: false
  end

  private

  def authorized?
    current_user&.parent?
  end

end
