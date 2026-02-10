class PagesController < ApplicationController

  skip_before_action :verify_authorized

  def index; end

end
