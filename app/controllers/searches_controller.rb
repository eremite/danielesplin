class SearchesController < ApplicationController

  load_and_authorize_resource :entry, :parent => false

  # TODO test
  def index
    @entries = @entries.where(Entry.arel_table[:body].matches("%#{params[:term].to_s.downcase}%"))
  end

end
