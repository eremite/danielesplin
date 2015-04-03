class Api::EntriesController < ApiController

  def create
    @entry = @user.entries.new(safe_params)
    if @entry.save
      render json: @entry, status: :created
    else
      render text: @entry.errors.full_messages.to_sentence, status: :not_acceptable
    end
  end


  private

  def safe_params
    params.require(:entry).permit(:at, :body, :public)
  end

end
