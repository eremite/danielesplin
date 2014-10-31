class InventoryItemsController < ApplicationController

  load_resource except: [:new, :create]
  authorize_resource

  def index
    begin
      @ends_on = Date.strptime(params[:ends_on].to_s, '%Y-%m-%d')
    rescue ArgumentError, TypeError
      flash[:error] = 'Invalid date' if params[:ends_on].present?
      @ends_on = Time.zone.today
    end
    @inventory_items = InventoryItem.on_desc.page(params[:page])
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

  def update
    if @inventory_item.update_attributes(safe_params)
      redirect_to :inventory_items, notice: "#{InventoryItem.model_name.human} saved."
    else
      render :edit
    end
  end

  def destroy
    @inventory_item.destroy
    redirect_to :inventory_items, notice: "#{InventoryItem.model_name.human} deleted."
  end


  private

  def safe_params
    params.permit(inventory_item: [:name, :on, :description, :cost_in_dollars, :value_in_dollars, :inventory_item_tag_list])[:inventory_item]
  end

end