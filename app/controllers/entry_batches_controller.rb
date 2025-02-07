class EntryBatchesController < ApplicationController

  def new
    @entry_batch = EntryBatch.new.load
  end

  def create
    EntryBatch.new(safe_params).save
    respond_to do |format|
      format.html do
        redirect_to [:entries, { on_this_day: 1 }]
      end
      format.json do
        head :ok
      end
    end
  end

  private

  def safe_params
    params.require(:entry_batch).permit!
  end

  def authorized?
    Current.user&.parent?
  end

end
