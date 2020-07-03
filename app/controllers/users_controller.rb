class UsersController < ApplicationController

  def index
    @users = User.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(safe_params)
    if @user.save
      redirect_to users_url, notice: 'User created.'
    else
      render :new
    end
  end

  def edit
    @user = User.find(current_user.guest? ? current_user.id: params[:id])
  end

  def update
    @user = User.find(current_user.guest? ? current_user.id: params[:id])
    if @user.update_attributes(safe_params)
      redirect_to edit_user_url(@user), notice: 'Changes saved.'
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, notice: 'User deleted.'
  end


  private

  def safe_params
    permitted_attributes = [:name, :email, :password, :password_confirmation]
    %i{role api_key born_at}.each do |field|
      permitted_attributes << field if current_user.parent?
    end
    params.require(:user).permit(*permitted_attributes)
  end

  def authorized?
    return false if current_user.nil?
    if current_user.guest?
      %w[edit update].include?(params[:action])
    else
      current_user.parent?
    end
  end

end
