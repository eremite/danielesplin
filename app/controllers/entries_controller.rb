class EntriesController < ApplicationController

  load_and_authorize_resource

  def index
    @interval = 1.week
    begin
      @starts_at = Time.zone.parse(params[:starts_at])
    rescue ArgumentError, TypeError
      flash[:error] = 'Invalid date' if params[:starts_at].present?
      @starts_at = Time.zone.now
    end
    @starts_at = (@starts_at - @starts_at.wday.day).beginning_of_day
    @ends_at = @starts_at + @interval - 1.second
    entries = @entries.private.at_desc.where(at: @starts_at..@ends_at)
    @grouped_entries = entries.group_by { |e| e.at.to_date }
  end


  def new
    if current_user.mother?
      @entry.at = Time.zone.now
    elsif current_user.father?
      @entry.at = (Time.zone.now - 1.day).beginning_of_day
    end
  end

  def create
    @entry = current_user.entries.new(params[:entry])
    if @entry.save
      redirect_to entries_url, notice: 'Entry saved.'
    else
      render :new
    end
  end

  # TODO test
  def show
  end

  def update
    if @entry.update_attributes(params[:entry])
      redirect_to entries_url, notice: 'Entry updated.'
    else
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry destroyed.'
  end

end
