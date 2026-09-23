require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest

  test 'new' do
    get '/ai'
    assert_response :success
  end

  test 'create' do
    AI.stub :ask, 'Carefully' do
      AI.stub :embed, [1] do
        post '/chats', params: { chat: { query: 'How?' } }
      end
    end
    assert_response :unprocessable_content
  end

end
