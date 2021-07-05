class NotesController < ApplicationController

  def index
    if params[:user_id].present?
      @notes = @notes.where(user_id: params[:user_id])
    else
      @notes = current_user.notes
    end
    if params[:kind].present?
      @notes = @notes.where(kind: params[:kind])
    end
    if params[:term].present?
      @notes = @notes.where(Note.arel_table[:body].matches("%#{params[:term].to_s.downcase}%"))
    end
    if params[:tag].present?
      @notes = @notes.tagged_with(params[:tag], on: :note_tags)
    end
    @notes =
      case params[:finished].to_s
      when 'Finished'
        @notes.where.not(finished_at: nil)
      when 'Unfinished', ''
        @notes.where(finished_at: nil)
      else
        @notes
      end
    if params[:random]
      @notes = @notes.where(id: @notes.sample.try(:id))
    end
    @notes = @notes.order(Note.arel_table[:updated_at].desc)
    @notes = @notes.page(params[:page])
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.new(safe_params)
    if @note.save
      redirect_to [:edit, @note], notice: 'Note saved.'
    else
      render :new
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(safe_params)
      redirect_to [:edit, @note], notice: 'Note saved.'
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to :notes, notice: 'Note destroyed.'
  end

  private

  def safe_params
    params.permit(note: [
      :body,
      :finished_at,
      :kind,
      :meta,
      :note_tag_list,
      :title,
      :user_id,
    ])[:note]
  end

  def authorized?
    current_user&.father?
  end

end
