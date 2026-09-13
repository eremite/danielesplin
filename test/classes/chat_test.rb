require 'test_helper'

class ChatTest < ActiveSupport::TestCase

  test 'ask! without query has no content' do
    chat = Chat.new(query: nil)
    chat.ask!
    assert_nil chat.content
  end

  test 'ask!' do
    chat = Chat.new(query: 'Why?')
    RubyLLM::Chat.stub_any_instance :ask, Data.define(:content).new(content: 'Why not?') do
      chat.ask!
    end
    assert_equal 'Why not?', chat.content
  end

end
