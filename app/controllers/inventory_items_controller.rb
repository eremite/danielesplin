class InventoryItemsController < ApplicationController

  def index
    @search = InventoryItemSearch.new(search_params).load
  end

  def new
    @inventory_item = InventoryItem.new(safe_params)
    @inventory_item.on ||= Time.zone.today
  end

  def edit
    @inventory_item = InventoryItem.find(params[:id])
  end

  def create
    @inventory_item = InventoryItem.new(safe_params)
    if @inventory_item.save
      redirect_to :inventory_items, notice: "#{InventoryItem.model_name.human} saved."
    else
      render :new
    end
  end

  def update
    @inventory_item = InventoryItem.find(params[:id])
    if @inventory_item.update(safe_params)
      redirect_to :inventory_items, notice: "#{InventoryItem.model_name.human} saved."
    else
      render :edit
    end
  end

  def destroy
    InventoryItem.find(params[:id]).touch(:deleted_at)
    redirect_to :inventory_items, notice: "#{InventoryItem.model_name.human} deleted."
  end

  private

  def safe_params
    params.permit(inventory_item: %i[name on description cost_in_dollars inventory_item_tag_list])[:inventory_item]
  end

  def search_params
    params.fetch(:inventory_item_search, {}).permit(:ends_on, :deleted, :order, :page, :term, :tag)
  end

  def authorized?
    Current.user&.parent?
  end

end
