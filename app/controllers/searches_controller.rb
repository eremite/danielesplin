class SearchesController < ApplicationController

  load_and_authorize_resource :entry, :parent => false

  def index
    @entries = @entries.at_desc.where(Entry.arel_table[:body].matches("%#{params[:term].to_s.downcase}%"))
  end

end
