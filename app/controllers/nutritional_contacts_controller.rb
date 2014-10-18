class NutritionalContactsController < ApplicationController

  layout 'nutritionalbites'

  def create
    if params[:body].present?
      user = User.where(role: 'father')
      user.entries.create(body: "New contact: #{params.inspect}")
      # Notifier.nutritional_contact_notification(params[:name], params[:email], params[:body]).deliver
    end
    redirect_to [:public_nutritional_posts], notice: 'Contact sent. Thanks!'
  end

end
