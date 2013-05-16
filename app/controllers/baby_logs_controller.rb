class BabyLogsController < ApplicationController

  load_and_authorize_resource

  def index
    if current_baby
      if params[:kind].present?
        @baby_logs = current_baby.baby_logs.kind(params[:kind]).at_asc
      else
        range = (Time.zone.now - 24.hours)..Time.zone.now
        base_query = current_baby.baby_logs.at_asc.where(:at => range)
        @baby_logs = Hash[BabyLog::KINDS.map do |kind|
          [kind, base_query.kind(kind)]
        end]
        @baby_log = current_baby.baby_logs.new
      end
    end
  end

  def new
    @baby_log = current_baby.baby_logs.new
  end

  def create
    @baby_log = current_baby.baby_logs.new(params[:baby_log])
    @baby_log.at = Time.zone.now
    if @baby_log.save
      redirect_to baby_logs_url, notice: 'Saved.'
    else
      render :new
    end
  end

  def update
    if @baby_log.update_attributes(params[:baby_log])
      redirect_to baby_logs_url, notice: 'Updated.'
    else
      render :edit
    end
  end

  def destroy
    @baby_log.destroy
    redirect_to baby_logs_url, notice: "OK, we'll pretend that never happened."
  end

end
