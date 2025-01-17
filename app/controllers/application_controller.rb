class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :authenticate, :verify_authorized

  rescue_from ActionController::MethodNotAllowed, ActionController::UnknownHttpMethod do |exception|
    render text: "ERROR: #{exception.message}", status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:method_not_allowed]
  end

  rescue_from ActionView::MissingTemplate do |exception|
    render text: "ERROR: #{exception.message}", status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_acceptable]
  end

  private

  def authenticate
    Current.user = User.find_by(id: session[:user_id])
  end

  def verify_authorized
    deny_access unless authorized?
  end

  def deny_access
    redirect_to :root, alert: 'Permission denied!'
  end

  def authorized?
    false
  end

end
