class SessionsController < ApplicationController

  skip_before_action :verify_authorized

  def new
    redirect_to :root if current_user.present?
  end

  def create
    if (user = User.find_by_email(params[:email]).try(:authenticate, params[:password]))
      user.log('login')
      session[:user_id] = user.id
      redirect_to current_user.login_redirect
    else
      redirect_to :root, alert: 'Invalid login or password.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

end
