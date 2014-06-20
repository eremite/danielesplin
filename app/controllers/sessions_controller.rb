class SessionsController < ApplicationController

  def new
  end

  def create
    if (user = User.find_by_email(params[:email]).try(:authenticate, params[:password]))
      user.log('login')
      session[:user_id] = user.id
      if (thought = user.thoughts.where(on: Time.zone.now.to_date).first)
        flash[:notice] = thought.body
      end
      if can? :create, Entry
        todays_entry = user.entries.journal.where(:at => Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).first
        redirect_to todays_entry ? [:edit, todays_entry] : new_entry_url
      else
        redirect_to blog_posts_url
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
