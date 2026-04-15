class EntriesController < ApplicationController
  def index
    @entry_search = EntrySearch.new(search_params).load
  end

  def edit
    @entry = find_entry
  end

  def create
    entry = Entry.create!(at: Time.current, user: Current.user, creator: Current.user)
    redirect_to [:edit, entry]
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
    params.permit(entry: %i[at user_id body entry_tag_list])[:entry]
  end

  def search_params
    params.fetch(:entry_search, {}).permit(
      :age, :ends_on, :entry_user, :on_this_day, :page, :random, :tag, :term, :user_id
    ).merge(current_user: Current.user)
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
