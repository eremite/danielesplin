class SessionsController < ApplicationController

  def new
  end

  def create
    if (user = User.find_by_email(params[:email]).try(:authenticate, params[:password]))
      user.log('login')
      session[:user_id] = user.id
      if can? :create, Entry
        todays_entry = user.entries.where(:at => Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).first
        redirect_to todays_entry ? [:edit, todays_entry] : new_entry_url
      else
        redirect_to :posts
      end
    else
      flash.now[:alert] = 'Invalid login or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
