class BabyLogsController < ApplicationController

  before_filter :find_baby

  load_and_authorize_resource

  def index
    if @baby
      @feedings = @baby.baby_logs.kind(:feeding)
      @wet_diapers = @baby.baby_logs.kind(:wet_diaper)
      @poopy_diapers = @baby.baby_logs.kind(:poopy_diaper)
      @baby_log = @baby.baby_logs.new
    end
  end

  def new
    @baby_log = @baby.baby_logs.new
  end

  def create
    @baby_log = @baby.baby_logs.new(params[:baby_log])
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


  private

  def find_baby
    @baby = User.find_by_email('baby@danielesplin.org')
  end

end
