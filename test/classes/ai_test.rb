require 'test_helper'

class AITest < ActiveSupport::TestCase

  class RubyLLMChatStub

    def ask(*_args)
      Data.define(:content).new(content: 'Answer')
    end

  end

  test 'embed' do
    embedding_result = Data.define(:vectors).new(vectors: [1])
    RubyLLM.stub :embed, embedding_result do
      assert_equal [1], AI.embed('content')
    end
  end

  test 'ask' do
    RubyLLM.stub :chat, RubyLLMChatStub.new do
      assert_equal 'Answer', AI.ask('Question')
    end
  end

end
