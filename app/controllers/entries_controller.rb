class EntriesController < ApplicationController

  def index
    @ends_on = parse_date(params[:ends_on])
    @entry_user = Current.user.users_whose_entries_i_can_edit.find_by(id: params[:user_id]) || Current.user
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
    if params[:random].to_i.nonzero?
      @entries = @entries.where(id: @entries.sample.try(:id))
    end
    if params[:on_this_day]
      entry = @entry_user.random_entry_on_the_same_day_of_the_year
      @entries = Entry.where(id: entry.id) if entry.present?
    end
    @entries = @entries.page(params[:page])
  end

  def create
    entry = Entry.create!(at: Time.current, user: Current.user, creator: Current.user)
    redirect_to [:edit, entry]
  end

  def edit
    @entry = find_entry
  end

  def update
    @entry = find_entry
    respond_to do |format|
      format.html do
        if @entry.update(safe_params)
          redirect_to @entry.after_create_redirect_url
        else
          render :edit
        end
      end
      format.json do
        head @entry.update(safe_params) ? :ok : :not_acceptable
      end
    end
  end

  def destroy
    find_entry.destroy
    redirect_to :entries, notice: 'Entry destroyed.'
  end

  private

  def find_entry
    Entry.where(user: Current.user.users_whose_entries_i_can_edit).find(params[:id])
  end

  def safe_params
    params.permit(entry: [:at, :user_id, :body, :entry_tag_list])[:entry]
  end

  def authorized?
    Current.user&.parent? || Current.user&.child?
  end

  def parse_date(date_string)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    Date.current
  end

end
