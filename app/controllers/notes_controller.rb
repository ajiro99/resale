class NotesController < ApplicationController
  def index
    @note_1 = Note.first
    @note_2 = Note.second
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to notes_path
    else
      render :index
    end
  end

  private

  def note_params
    params.require(:note).permit(:note)
  end
end
