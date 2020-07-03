class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :verify_authorized

  rescue_from ActionController::MethodNotAllowed, ActionController::UnknownHttpMethod do |exception|
    render text: "ERROR: #{exception.message}", status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:method_not_allowed]
  end

  rescue_from ActionView::MissingTemplate do |exception|
    render text: "ERROR: #{exception.message}", status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_acceptable]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def verify_authorized
    deny_access unless authorized?
  end

  def deny_access
    redirect_to :login, alert: 'Permission denied!'
  end

  def authorized?
    false
  end

end
