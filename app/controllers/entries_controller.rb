class EntriesController < ApplicationController

  load_and_authorize_resource

  def create
    @entry = current_user.entries.new(params[:entry])
    if @entry.save
      redirect_to entries_url
    else
      render :new
    end
  end

  def update
    if @entry.update_attributes(params[:entry])
      puts 'saved'
      redirect_to entries_url
    else
      puts 'edit'
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry destroyed.'
  end

end
