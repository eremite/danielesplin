class EntryBatchesController < ApplicationController

  def new
    @entry_batch = EntryBatch.new.load
  end

  def create
    EntryBatch.new(safe_params).save
    redirect_to [:entries, { on_this_day: 1 }]
  end

  private

  def safe_params
    params.require(:entry_batch).permit!
  end

  def authorized?
    current_user&.parent?
  end

end
