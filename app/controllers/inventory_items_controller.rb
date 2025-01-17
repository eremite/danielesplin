class InventoryItemsController < ApplicationController

  def index
    begin
      @ends_on = Date.strptime(params[:ends_on].to_s, '%Y-%m-%d')
    rescue ArgumentError, TypeError
      flash[:error] = 'Invalid date' if params[:ends_on].present?
      @ends_on = Time.zone.today
    end
    @inventory_items = InventoryItem.all
    @inventory_items = params[:deleted].to_i.nonzero? ? @inventory_items.deleted : @inventory_items.not_deleted
    @inventory_items = params[:order] == "on_asc" ? @inventory_items.order(on: :asc) : @inventory_items.on_desc
    @inventory_items = @inventory_items.page(params[:page])
    @inventory_items = @inventory_items.before(@ends_on.end_of_day) if params[:ends_on].present?
    if params[:term].present?
      term = "%#{params[:term].to_s.downcase}%"
      @inventory_items = @inventory_items.where(
        InventoryItem.arel_table[:name].matches(term).or(InventoryItem.arel_table[:description].matches(term))
      )
    end
    if params[:tag].present?
      @inventory_items = @inventory_items.tagged_with(params[:tag], on: :inventory_item_tags)
    end
  end

  def new
    @inventory_item = InventoryItem.new(safe_params)
    @inventory_item.on ||= Time.zone.today
  end

  def create
    @inventory_item = InventoryItem.new(safe_params)
    if @inventory_item.save
      redirect_to :inventory_items, notice: "#{InventoryItem.model_name.human} saved."
    else
      render :new
    end
  end

  def edit
    @inventory_item = InventoryItem.find(params[:id])
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
    params.permit(inventory_item: [:name, :on, :description, :cost_in_dollars, :inventory_item_tag_list])[:inventory_item]
  end

  def authorized?
    Current.user&.parent?
  end

end
