class ReportsController < ApplicationController

  authorize_resource :class => false

  def unblogged_photos
    @photos = Photo.unblogged
  end

  def untimed_photos
    @photos = Photo.where(:at => nil)
  end

end
