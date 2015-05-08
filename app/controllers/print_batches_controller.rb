class PrintBatchesController < ApplicationController

  authorize_resource :class => false

  def index
    @users = User.where(role: %w(father mother baby)).order(User.arel_table[:id].asc)
  end

  def print
    @user = User.find(params[:user_id])
    starts_on = Time.zone.parse("#{params[:year]}-01-01")
    @entries = @user.entries.where(at: starts_on..starts_on.end_of_year)
    render :print, layout: false
  end

end
