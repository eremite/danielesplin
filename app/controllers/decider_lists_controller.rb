class DeciderListsController < ApplicationController

  before_action :verify_authorized

  def index
    @lists = DeciderList.order(name: :asc)
  end

  def new
    @list = DeciderList.new
  end

  def create
    @list = DeciderList.new(safe_params)
    if @list.save
      redirect_to @list
    else
      render :new
    end
  end

  def show
    @list = DeciderList.find(params[:id])
  end

  def edit
    @list = DeciderList.find(params[:id])
  end

  def update
    @list = DeciderList.find(params[:id])
    if @list.update(safe_params)
      redirect_to @list
    else
      render :edit
    end
  end

  def destroy
    list = DeciderList.find(params[:id])
    list.destroy
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
