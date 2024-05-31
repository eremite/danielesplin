class EntriesController < ApplicationController

  def index
    @ends_on = Date.parse(params[:ends_on] || Date.current.to_s)
    @entry_user = current_user.users_whose_entries_i_can_edit.find_by(id: params[:user_id]) || current_user
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
    @entries = @entries.page(params[:page])
  end

  def create
    entry = Entry.create!(at: Time.current, user_id: current_user.id)
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
    Entry.where(user: current_user.users_whose_entries_i_can_edit).find(params[:id])
  end

  def safe_params
    params.permit(entry: [:at, :user_id, :body, :entry_tag_list])[:entry]
  end

  def authorized?
    current_user&.parent? || current_user&.child?
  end

end
