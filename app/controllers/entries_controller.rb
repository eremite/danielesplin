class EntriesController < ApplicationController

  load_resource except: :create
  authorize_resource

  def index
    begin
      @ends_on = Date.strptime(params[:ends_on].to_s, '%m/%d/%Y')
    rescue ArgumentError, TypeError
      flash[:error] = 'Invalid date' if params[:ends_on].present?
      @ends_on = Time.zone.now.to_date
    end
    @entry_user = User.where(id: params[:user_id]).first
    if current_user.grandparent?
      @entry_user ||= User.where(role: 'baby').first
      if !@entry_user.baby?
        @ends_on = Time.zone.parse('2000-01-01') if @ends_on > Time.zone.parse('2000-01-01')
      end
    else
      @entry_user ||= current_user
    end
    @entries = Entry.where(user: @entry_user).private.at_desc.before(@ends_on.end_of_day).page(params[:page])
    if params[:term].present?
      @entries = @entries.where(Entry.arel_table[:body].matches("%#{params[:term].to_s.downcase}%"))
    end
  end

  def new
    @entry.at = Time.zone.now
  end

  def create
    @entry = Entry.new(safe_params)
    if @entry.save
      redirect_to new_entry_url
    else
      render :new
    end
  end

  # TODO test
  def show
  end

  def update
    if @entry.update_attributes(safe_params)
      params.delete(:redirect_to) if params[:redirect_to] == root_url
      redirect_to params[:redirect_to].presence || entries_url, notice: 'Entry saved.'
    else
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry destroyed.'
  end


  private

  def safe_params
    params.require(:entry).permit(:at, :user_id, :body, :public)
  end

end
