class LessonsController < ApplicationController

  def index
    @lessons = Current.user.lessons.answered.order(created_at: :asc).page(params[:page])
    @lessons = @lessons.where(dismissed_at: nil) unless params[:show_all] == 'true'
  end

  def edit
    @lesson = Lesson.find(params.expect(:id))
  end

  def create
    lesson = Current.user.lessons.new(safe_params)
    if lesson.save
      redirect_to :lessons, notice: 'Saved'
    else
      redirect_to :lessons, alert: lesson.errors.full_messages.to_sentence
    end
  end

  def update
    @lesson = Lesson.find(params.expect(:id))
    if @lesson.update(safe_params)
      redirect_to :lessons, notice: 'Saved'
    else
      render :edit
    end
  end

  def destroy
    Lesson.find(params.expect(:id)).destroy
    redirect_to :lessons, notice: 'Lesson deleted.'
  end

  private

  def authorized?
    Current.user&.parent? || Current.user&.child?
  end

  def safe_params
    params.permit(lesson: %i[question])[:lesson]
  end

end
