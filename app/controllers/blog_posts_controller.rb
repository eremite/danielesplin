class BlogPostsController < ApplicationController

  authorize_resource :class => false

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
    photos = Photo.newest_first.where(at: @starts_at..@ends_at)
    @grouped_photos = photos.group_by { |p| p.at.to_date }
    entries = Entry.public.newest_first.where(at: @starts_at..@ends_at)
    @grouped_entries = entries.group_by { |e| e.at.to_date }
  end

  def new
    @entry = Entry.public.new
    @entry.at = Time.zone.now
  end

  def create
    @entry = current_user.entries.public.new(params[:entry])
    if @entry.save
      redirect_to blog_posts_url, notice: 'Blog Post saved.'
    else
      render :new
    end
  end

end
