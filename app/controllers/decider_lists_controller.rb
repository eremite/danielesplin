class DeciderListsController < ApplicationController

  before_action :verify_authorized

  def index
    @lists = DeciderList.order(name: :asc)
  end

  def show
    @list = DeciderList.find(params[:id])
  end

  private

  def authorized?
    current_user.present?
  end

end
