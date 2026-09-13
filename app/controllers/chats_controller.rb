class ChatsController < ApplicationController

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(safe_params)
    @chat.ask!
    render :new, status: :unprocessable_content
  end

  private

  def safe_params
    params.expect(chat: %i[query])
  end

  def authorized?
    return true unless Rails.env.production?
    ENV['PHOTO_FRAME_IP'].to_s.split.include?(request.remote_ip)
  end

end
