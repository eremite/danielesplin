class ReportsController < ApplicationController

  authorize_resource :class => false

  def users
    @users = User.all
  end

  def unblogged_photos
    entry_dates = Entry.public.all.map { |e| e.at.to_date }
    @photos = Photo.where(["DATE(photos.at) NOT IN (?)", entry_dates]).page(params[:page])
  end

end
