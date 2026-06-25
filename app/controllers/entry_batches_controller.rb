class EntryBatchesController < ApplicationController

  def new
    @entry_batch = EntryBatch.new.load
  end

  def create
    EntryBatch.new(safe_params).save
    respond_to do |format|
      format.html do
        entry = Entry.create!(at: Time.current, user: Current.user, creator: Current.user)
        redirect_to [:edit, entry]
      end
      format.json do
        head :ok
      end
    end
  end

  private

  def safe_params
    params.expect(entry_batch: [{ entry_params_by_user_id: {} }])
  end

  def authorized?
    Current.user&.parent?
  end

end
