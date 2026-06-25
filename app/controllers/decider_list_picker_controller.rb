class DeciderListPickerController < ApplicationController

  skip_before_action :verify_authorized

  def index
    @lists = DeciderList.order(name: :asc)
  end

  def new
    @list = DeciderList.find(params.expect(:id))
  end

  def create
    @item = DeciderList.find(params.expect(:id)).pick
  end

end
