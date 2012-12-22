class Api::EntriesController < ApiController

  respond_to :json

  def create
    @entry = @user.entries.new(params[:entry])
    if @entry.save
      respond_with(@entry, status: :created)
    else
      render text: @entry.errors.full_messages.to_sentence, status: :not_acceptable
    end
  end

end
