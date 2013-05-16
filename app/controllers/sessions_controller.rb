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
      redirect_to can?(:create, Entry) ? new_entry_url : blog_posts_url
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
