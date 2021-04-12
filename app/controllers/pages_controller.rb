class PagesController < ApplicationController

  skip_before_action :verify_authorized

  def index
    redirect_to :visible_posts if current_user&.guest?
  end

end
