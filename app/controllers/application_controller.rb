class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:format])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_url, alert: 'Permission denied!'
  end

end
