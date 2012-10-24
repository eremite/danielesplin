class ReportsController < ApplicationController

  authorize_resource :class => false

  def users
    @users = User.all
  end

  def unblogged_photos
    @photos = []
    Photo.where(Photo.arel_table[:at].not_eq(nil)).each do |photo|
      range = photo.at.beginning_of_day...photo.at.end_of_day
      @photos << photo if Entry.where(:at => range).empty?
    end
  end

end
