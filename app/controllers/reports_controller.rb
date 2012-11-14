class ReportsController < ApplicationController

  authorize_resource :class => false

  def users
    @users = User.all
  end

  def unblogged_photos
    @photos = Photo.unblogged
  end

end
