class EntriesController < ApplicationController

  def index
    begin
      @ends_on = Date.strptime(params[:ends_on].to_s, '%m/%d/%Y')
    rescue ArgumentError, TypeError
      flash[:error] = 'Invalid date' if params[:ends_on].present?
      @ends_on = Time.zone.now.to_date
    end
    @entry_user = User.where(id: params[:user_id]).first
    if current_user.grandparent?
      @entry_user ||= User.where(role: 'baby').first
      if !@entry_user.baby?
        @ends_on = Time.zone.parse('2000-01-01') if @ends_on > Time.zone.parse('2000-01-01')
      end
    else
      @entry_user ||= current_user
    end
    if @entry_user.born_at.present? && (params[:age_months].present? || params[:age_years].present?)
      @ends_on = @entry_user.born_at + params[:age_months].to_i.months + params[:age_years].to_i.years
    end
    @entries = Entry.where(user: @entry_user).at_desc.before(@ends_on.end_of_day)
    if params[:term].present?
      @entries = @entries.where(Entry.arel_table[:body].matches("%#{params[:term].to_s.downcase}%"))
    end
    if params[:tag].present?
      @entries = @entries.tagged_with(params[:tag], on: :entry_tags)
    end
    if params[:random]
      @entries = @entries.where(id: @entries.sample.try(:id))
    end
    @entries = @entries.page(params[:page])
  end

  def new
    @entry = Entry.new(safe_params)
    @entry.at ||= Time.zone.now
    @entry.user ||= current_user
  end

  def create
    @entry = Entry.new(safe_params)
    if @entry.save
      redirect_to @entry.after_create_redirect_url
    else
      render :new
    end
  end

  # TODO test
  def show
    @entry = Entry.find(params[:id])
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(safe_params)
      params.delete(:redirect_to) if params[:redirect_to] == root_url
      redirect_to params[:redirect_to].presence || entries_url, notice: 'Entry saved.'
    else
      render :edit
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to entries_url, notice: 'Entry destroyed.'
  end


  private

  def safe_params
    params.permit(entry: [:at, :user_id, :body, :entry_tag_list])[:entry]
  end

  def authorized?
    current_user&.parent?
  end

end
