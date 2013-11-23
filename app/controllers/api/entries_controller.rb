class Api::EntriesController < ApiController

  respond_to :json

  def create
    @entry = @user.entries.new(safe_params)
    if @entry.save
      respond_with(@entry, status: :created)
    else
      render text: @entry.errors.full_messages.to_sentence, status: :not_acceptable
    end
  end


  private

  def safe_params
    params.require(:entry).permit(:at, :body, :public, :baby_body)
  end

end
