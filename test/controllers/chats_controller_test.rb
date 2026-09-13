require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest

  test 'new' do
    get '/ai'
    assert_response :success
  end

  test 'create' do
    post '/chats', params: { chat: { query: 'How?' } }
    assert_response :unprocessable_content
  end

end
