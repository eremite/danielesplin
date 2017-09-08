class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :verify_api_key

  private

  def verify_api_key
    @user = User.where(api_key: params[:api_key]).first
    if params[:api_key].blank? || @user.nil?
      render text: 'Invalid API Key.', status: :unauthorized
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    render text: 'Access Denied.', status: :unauthorized
  end

end
