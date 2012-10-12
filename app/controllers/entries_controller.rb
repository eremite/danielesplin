class EntriesController < ApplicationController

  load_and_authorize_resource

  def index
    @interval = 1.week
    begin
      @starts_at = Time.zone.parse(params[:starts_at])
    rescue ArgumentError, TypeError
      flash[:error] = 'Invalid date' if params[:starts_at].present?
      @starts_at = (Time.zone.now - @interval).beginning_of_week
    end
    @ends_at = @starts_at + @interval
    photos = Photo.oldest_first.where(at: @starts_at..@ends_at)
    @grouped_photos = photos.group_by { |p| p.at.to_date }
    entries = @entries.oldest_first.where(at: @starts_at..@ends_at)
    @grouped_entries = entries.group_by { |e| e.at.to_date }
  end

  def create
    @entry = current_user.entries.new(params[:entry])
    if @entry.save
      redirect_to entries_url
    else
      render :new
    end
  end

  def update
    if @entry.update_attributes(params[:entry])
      redirect_to entries_url
    else
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry destroyed.'
  end

end
