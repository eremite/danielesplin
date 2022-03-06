class DeciderListsController < ApplicationController

  before_action :verify_authorized

  def index
    @lists = DeciderList.order(name: :asc)
  end

  def create
    @list = DeciderList.new(safe_params)
    if @list.save
      redirect_to @list
    else
      redirect_to :decider_lists, alert: @list.errors.full_messages.to_sentence
    end
  end

  def show
    @list = DeciderList.find(params[:id])
  end

  def destroy
    DeciderList.find(params[:id]).destroy
    redirect_to :decider_lists
  end

  private

  def authorized?
    current_user.present?
  end

  def safe_params
    params.require(:decider_list).permit(:name)
  end

end
