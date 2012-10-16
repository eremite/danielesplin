class UsersController < ApplicationController

  load_and_authorize_resource

  def update
    if @user.update_attributes(params[:user])
      redirect_to edit_user_url(@user), notice: 'Changes saved.'
    else
      render :edit
    end
  end

end
