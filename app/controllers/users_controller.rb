class UsersController < ApplicationController

  load_and_authorize_resource

  def create
    if @user.save
      redirect_to users_url, notice: 'User created.'
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(safe_params)
      redirect_to edit_user_url(@user), notice: 'Changes saved.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User deleted.'
  end


  private

  def safe_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
