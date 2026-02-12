class SessionsController < ApplicationController

  skip_before_action :verify_authorized

  def create
    user = User.where.not(password_digest: [nil, '']).where.not(role: %w[guest inactive]).find_by(email: params[:email])
    if user&.authenticate(params[:password])
      user.log('login')
      session[:user_id] = user.id
      redirect_to user.login_redirect
    else
      redirect_to :root, alert: 'Invalid login or password.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

end
