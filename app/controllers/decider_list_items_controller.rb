class DeciderListItemsController < ApplicationController

  before_action :verify_authorized

  def new
    list = DeciderList.find(params[:decider_list_id])
    @item = list.items.new
  end

  def create
    flash.notice = "Item added to list"
    item = DeciderListItem.new(safe_params)
    if item.save
      redirect_to item.decider_list
    else
      render :new
    end
  end

  def destroy
    item = DeciderListItem.find(params[:id])
    item.destroy
    redirect_to item.decider_list
  end

  private

  def authorized?
    current_user.present?
  end

  def safe_params
    params.require(:decider_list_item).permit(:name, :decider_list_id)
  end

end
