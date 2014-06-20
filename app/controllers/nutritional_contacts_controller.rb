class NutritionalContactsController < ApplicationController

  layout 'nutritionalbites'

  def create
    if params[:body].present?
      Notifier.nutritional_contact_notification(params[:name], params[:email], params[:body]).deliver
    end
    redirect_to [:public_nutritional_posts], notice: 'Contact sent. Thanks!'
  end

end
