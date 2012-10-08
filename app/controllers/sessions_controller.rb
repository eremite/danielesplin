class SessionsController < ApplicationController

  def new
  end

  def create
    if (user = User.find_by_email(params[:email]).try(:authenticate, params[:password]))
      session[:user_id] = user.id
      redirect_to photos_url, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid login or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You have been logged out.'
  end

end
