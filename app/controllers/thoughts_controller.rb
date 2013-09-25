class ThoughtsController < ApplicationController

  load_resource except: :create
  authorize_resource

  def index
    @thought = Thought.new(:on => Date.tomorrow)
    @thought.user = User.where(role: 'mother').first
    if params[:kind] == 'past'
      @thoughts = @thoughts.where(Thought.arel_table[:on].lt(Time.zone.now.to_date))
    else
      @thoughts = @thoughts.where(Thought.arel_table[:on].gt(Time.zone.now.to_date))
    end
    @thoughts = @thoughts.order(Thought.arel_table[:on].asc)
  end

  def create
    @thought = Thought.new(safe_params)
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
    if @thought.update_attributes(safe_params)
      redirect_to thoughts_url, notice: 'Thought updated.'
    else
      render :edit
    end
  end

  def destroy
    @thought.destroy
    redirect_to thoughts_url, notice: 'Thought destroyed.'
  end


  private

  def safe_params
    params.require(:thought).permit(:on, :user, :body)
  end

end
