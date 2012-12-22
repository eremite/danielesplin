class ApiController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :verify_api_key

  private

  def verify_api_key
    if params[:api_key] == 'CHEESE_IS_TASTY'
      @user = User.find_by_email('daniel@danielesplin.org')
    elsif params[:api_key] == 'EAT_YOUR_VEGGIES'
      @user = User.find_by_email('erika@danielesplin.org')
    else
      render text: 'Invalid API Key.', status: :unauthorized
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    render text: 'Access Denied.', status: :unauthorized
  end

end
