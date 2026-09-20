require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest

  test 'new' do
    get '/ai'
    assert_response :success
  end

  test 'create' do
    AI.stub :ask, 'Carefully' do
      post '/chats', params: { chat: { query: 'How?' } }
    end
    assert_response :unprocessable_content
  end

end
