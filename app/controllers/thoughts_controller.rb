class ThoughtsController < ApplicationController

  load_and_authorize_resource

  def index
    @thought = Thought.new(:on => Date.tomorrow)
    @thought.user = User.find_by_email('erika@danielesplin.org')
    @thoughts = @thoughts.order(Thought.arel_table[:on].desc)
  end

  def create
    if @thought.save
      redirect_to thoughts_url, notice: 'Thought saved.'
    else
      @thoughts = Thought.order(Thought.arel_table[:on].desc)
      render :index
    end
  end

  def destroy
    @thought.destroy
    redirect_to thoughts_url, notice: 'Thought destroyed.'
  end

end
