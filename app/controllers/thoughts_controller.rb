class ThoughtsController < ApplicationController

  load_and_authorize_resource

  def index
    @thought = Thought.new(:on => Date.tomorrow)
    @thought.user = User.find_by_email('erika@danielesplin.org')
    if params[:kind] == 'past'
      @thoughts = @thoughts.where(Thought.arel_table[:on].lt(Time.zone.now.to_date))
    else
      @thoughts = @thoughts.where(Thought.arel_table[:on].gt(Time.zone.now.to_date))
    end
    @thoughts = @thoughts.order(Thought.arel_table[:on].asc)
  end

  def create
    if @thought.save
      redirect_to thoughts_url, notice: 'Thought saved.'
    else
      @thoughts = Thought.order(Thought.arel_table[:on].desc)
      render :edit
    end
  end

  def edit
  end

  def update
    if @thought.update_attributes(params[:thought])
      redirect_to thoughts_url, notice: 'Thought updated.'
    else
      render :edit
    end
  end

  def destroy
    @thought.destroy
    redirect_to thoughts_url, notice: 'Thought destroyed.'
  end

end
