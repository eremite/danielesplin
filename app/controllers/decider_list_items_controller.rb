class DeciderListItemsController < ApplicationController

  before_action :verify_authorized

  def create
    item = DeciderListItem.new(safe_params)
    if item.save
      redirect_to item.decider_list, notice: "Item added to list"
    else
      redirect_to item.decider_list, alert: item.errors.full_messages.to_sentence
    end
  end

  def destroy
    item = DeciderListItem.find(params[:id])
    item.destroy
    redirect_to item.decider_list
  end

  private

  def authorized?
    Current.user.present?
  end

  def safe_params
    params.require(:decider_list_item).permit(:name, :decider_list_id)
  end

end
