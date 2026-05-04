class NotesController < ApplicationController

  def index
    @search = NoteSearch.new(search_params).load
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def edit
    @note = Note.find(params[:id])
  end

  def create
    @note = Current.user.notes.new(safe_params)
    if @note.save
      redirect_to [:edit, @note], notice: 'Note saved.'
    else
      render :new
    end
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

  def search_params
    params.fetch(:note_search, {}).permit(
      :user_id, :kind, :term, :tag, :random
    ).merge(current_user: Current.user).merge(params.permit(:page))
  end

  def safe_params
    params.permit(note: %i[body kind meta note_tag_list title user_id])[:note]
  end

  def authorized?
    Current.user&.father?
  end

end
